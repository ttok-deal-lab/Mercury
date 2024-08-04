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

public struct NetworkManager<Target: TargetType> {
  
  // MARK: - private properties
  
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
    return ReachabilityManager.shared.isOnline()
      .flatMap { isOnline -> Future<Result<Data, MercuryError>, Never> in
        Future<Result<Data, MercuryError>, Never> { promise in
          guard isOnline else {
            promise(.success(.failure(.init(from: .ownModule(.data), type: .failToConnectInternet))))
            return
          }
          self.provider.request(target) { result in
            switch result {
            case .success(let response):
              do {
                let response = try response.filterSuccessfulStatusCodes()
                promise(.success(.success(response.data)))
              } catch {
                promise(.success(.failure(.init(from: .ownModule(.data), type: .failToResponseData))))
              }
            case .failure(let error):
              promise(.success(.failure(.init(error))))
            }
          }
      }
    }
    .eraseToAnyPublisher()
  }
}

