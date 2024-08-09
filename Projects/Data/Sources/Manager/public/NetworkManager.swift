//
//  NetworkManager.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import Combine
import Moya
import Alamofire
import CombineMoya
import AppFoundation

protocol Networkable {
  associatedtype Target
  func request(target: Target) async -> AnyPublisher<Result<Data, MercuryError>, Never>
}

public class NetworkManager<Target: TargetType> {
  
  // MARK: - private properties
  
  private let reachabilityManager = ReachabilityManager.shared
  
  private let provider: MoyaProvider<Target>
  
  private let queue: DispatchQueue = DispatchQueue(label: "com.network.merucry", qos: .utility)
  
  private let logger = NetworkLoggerPlugin(
    configuration: NetworkLoggerPlugin.Configuration(
      logOptions: [
        .requestHeaders,
        .requestBody,
        .requestMethod,
        .successResponseBody,
        .errorResponseBody
      ]
    )
  )
  
  // MARK: - life cycle
  
  public init() {
    self.provider = MoyaProvider<Target>(
      callbackQueue: nil,
      session: AlamofireSession.configuration,
      plugins: [logger]
    )
  }
  
  // MARK: - private method
  
  // MARK: - public method
}

extension NetworkManager: Networkable {
  
  public func request(target: Target) async -> AnyPublisher<Result<Data, MercuryError>, Never> {
    return reachabilityManager.isOnline()
      .flatMap { [weak self] isOnline -> Future<Result<Data, MercuryError>, Never> in
        Future<Result<Data, MercuryError>, Never> { promise in
          guard isOnline else {
            promise(.success(.failure(.init(from: .server, .failToConnectInternet))))
            return
          }
          self?.queue.async { [weak self] in
            self?.provider.request(target) { result in
              switch result {
              case .success(let response):
                do {
                  let response = try response.filterSuccessfulStatusCodes()
                  promise(.success(.success(response.data)))
                } catch {
                  promise(.success(.failure(.init(from: .server, .failToStatusCodes))))
                }
              case .failure(let error):
                promise(.success(.failure(.init(code: (error as NSError).code))))
              }
            }
          }
      }
    }
    .eraseToAnyPublisher()
  }
}


