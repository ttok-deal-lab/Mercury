//
//  ContentView.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var testModelData = TestModelData()
  
  var body: some View {
    VStack {
      Text(testModelData.joke?.setup ?? "no setup")
      Text(testModelData.joke?.delivery ?? "no delivery")
    }
    .task {
      do {
        try await testModelData.fetchingJoke()
      } catch {
        print(error)
      }
    }
    
  }

}
