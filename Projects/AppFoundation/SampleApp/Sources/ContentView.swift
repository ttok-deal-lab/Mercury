//
//  ContentView.swift
//  AppFoundation
//
//  Created by 송하민 on 11/2/24.
//

import SwiftUI

import AppFoundation

struct ContentView: View {
  @LazyInject var logger: MockLoggerProtocol
  
  var body: some View {
    VStack {
      Text("!!!!")
    }
    .onAppear {
      logger.log()
    }
    
  }
}
