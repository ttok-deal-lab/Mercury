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

// AppFoundation 모듈로 옮길것

public class MercuryError: Error {
  
  enum ErrorFrom {
    case server
    case ownModule(ModuleFrom)
    
    enum ModuleFrom {
      case uiComponent
      case doamin
      case analysis
      case auction
      case mainTabbar
      case appleSignin
      case googleSignin
    }
  }
  
  var description: String?
  let errorFrom: ErrorFrom
  
  init(_ from: ErrorFrom, error: any Error) {
    self.errorFrom = from
    self.description = error.localizedDescription
  }
  
  init(_ type: MercuryErrorType) {
    self.errorFrom = .server
  }
  
  init(_ error: Error) {
    self.errorFrom = .server
  }
}

enum MercuryErrorType {
  case noData
}

// AppFoundation 모듈로 옮길것




protocol Networkable {
  associatedtype Target
  func request(target: Target) async -> AnyPublisher<Result<Data, MercuryError>, Never>
}

public struct NetworkManager<Target: TargetType> {
  
  // MARK: - private properties
  
  private let provider: MoyaProvider<Target>
  
  private let queue: DispatchQueue = DispatchQueue(label: "com.network.merucry", qos: .utility)
  
  private let logger = NetworkLoggerPlugin()
  
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
          if !isOnline {
            promise(.success(.failure(.init(.noData))))
          } else {
            self.provider.request(target) { result in
              switch result {
              case .success(let response):
                if (200...299).contains(response.statusCode) {
                  promise(.success(.success(response.data)))
                } else {
                  promise(.success(.failure(.init(.noData))))
                }
              case .failure(let error):
                promise(.success(.failure(.init(error))))
              }
            }
          }
      }
    }
    .eraseToAnyPublisher()
  }
}


