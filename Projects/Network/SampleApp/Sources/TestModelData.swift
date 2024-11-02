//
//  TestModelData.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import SwiftUI

import Network

class JokeFetcher: ObservableObject {
  @Published var joke: JokeInfo?
  
  func fetch() async throws {
    let joke = try await MockRenewalAPI.mockingAPI.request(JokeInfo.self)
    await MainActor.run { [weak self] in
      self?.joke = joke
    }
  }
}
