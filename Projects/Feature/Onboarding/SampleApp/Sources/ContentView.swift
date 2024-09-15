//
//  ContnetView.swift
//  AppleSignInSampleApp
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import Onboarding

struct ContentView: View {
  var body: some View {
    VStack {
      AppleSignInButton()
      GoogleSignInButton()
    }
  }
}
