//
//  ContentView.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import SwiftUI

struct ContentView: View {
  @StateObject private var jokeFetcher = JokeFetcher()
  
  var body: some View {
    VStack {
      if let joke = jokeFetcher.joke?.joke {
        Text(joke)
      } else {
        Text(jokeFetcher.joke?.setup ?? "no setup")
        Text(jokeFetcher.joke?.delivery ?? "no delivery")
      }
      Button {
        Task {
          try await jokeFetcher.fetch()
        }
      } label: {
        Text("refresh joke")
      }
    }
    .task {
      do {
        try await jokeFetcher.fetch()
      } catch {
        print(error)
      }
    }
    
  }

}

