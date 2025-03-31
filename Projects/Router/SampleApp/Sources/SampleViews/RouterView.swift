//
//  RouterView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Router

struct RouterView: View {
  @EnvironmentObject var coordinator: GlobalCoordinator<SampleRoute>
  
  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 4) {
        ForEach(SampleRoute.allCases) { route in
          Button {
            coordinator.push(route)
          } label: {
            Text("push goto \(route.rawValue)")
              .foregroundStyle(.black)
          }
        }
        
        ForEach(SampleRoute.allCases) { route in
          Button {
            coordinator.presentFullScreen(route)
          } label: {
            Text("full screen present \(route.rawValue)")
              .foregroundStyle(.black)
          }
        }
        
        Button {
          coordinator.pop()
        } label: {
          Text("pop")
        }
        
        
        Button {
          coordinator.dismissFullScreen()
        } label: {
          Text("dismiss fullScreen")
        }
        
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 20)
    
    PushPrintView()
    FullScreenPrintView()
  }
}
