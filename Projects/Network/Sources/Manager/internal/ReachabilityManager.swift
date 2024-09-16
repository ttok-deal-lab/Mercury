//
//  ReachabilityManager.swift
//  DataSampleApp
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import Combine
import Alamofire

public class ReachabilityManager: NSObject {
  
  // MARK: - properties
  
  private let reachSubject = CurrentValueSubject<Bool, Never>(false)
  private lazy var bufferSubject: Publishers.Buffer<CurrentValueSubject<Bool, Never>> = reachSubject.buffer(size: 1, prefetch: .keepFull, whenFull: .dropOldest)
  
  
  // MARK: - internal properites
  
  var reachPublisher: AnyPublisher<Bool, Never> {
    bufferSubject.eraseToAnyPublisher()
  }
  
  
  // MARK: - life cycle

  static let shared = ReachabilityManager()
  
  override init() {
    super.init()
    self.setupReachabilityObserver()
  }
  
  
  // MARK: - private method
  
  private func setupReachabilityObserver() {
    NetworkReachabilityManager.default?.startListening(onUpdatePerforming: { status in
      let reachable = (status != .notReachable && status != .unknown)
      self.reachSubject.send(reachable)
    })
  }
  
  
  // MARK: - internal method
  
  func isOnline() -> AnyPublisher<Bool, Never> {
    return bufferSubject.first().eraseToAnyPublisher()
  }
  
}
