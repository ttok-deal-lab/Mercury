//
//  NetworkMonitor.swift
//  MercuryApp
//
//  Created by 송하민 on 6/8/25.
//

import Network
import SwiftUI
import Combine

@Observable
public final class NetworkMonitor {
  public var isConnected: Bool = true
  
  public static let shared = NetworkMonitor()
  
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue.global(qos: .background)
  
  private init() {
    monitor.pathUpdateHandler = { [weak self] path in
      let newStatus = path.status == .satisfied
      DispatchQueue.main.async {
        self?.isConnected = newStatus
      }
    }
    monitor.start(queue: queue)
  }
}
