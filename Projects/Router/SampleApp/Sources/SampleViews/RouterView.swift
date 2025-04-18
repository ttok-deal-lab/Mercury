//
//  RouterView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router

struct RouterView: View {
  var coordinator: PassthroughSubject<NavigationEvent<SampleRoute>, Never>
  
  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 4) {
        ForEach(SampleRoute.allCases) { route in
          Button {
            coordinator.send(.push(route))
          } label: {
            Text("push goto \(route.rawValue)")
              .foregroundStyle(.black)
          }
        }
        
        ForEach(SampleRoute.allCases) { route in
          Button {
            coordinator.send(.presentFullScreen(route))
          } label: {
            Text("full screen present \(route.rawValue)")
              .foregroundStyle(.black)
          }
        }
        
        Button {
          coordinator.send(.pop)
        } label: {
          Text("pop")
        }
        
        Button {
          coordinator.send(.dismissFullScreen)
        } label: {
          Text("dismiss fullScreen")
        }
        
        Button {
          coordinator.send(.popTo(SampleRoute.b))
        } label: {
          Text("pop to B if it's stacked")
        }
        
      }
    }
    .frame(maxWidth: .infinity)
    .padding(.top, 20)
  }
}
