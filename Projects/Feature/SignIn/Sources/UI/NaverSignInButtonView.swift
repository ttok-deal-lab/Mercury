//
//  NaverSignInButtonView.swift
//  SignIn
//
//  Created by 최수훈 on 1/17/25.
//

import Foundation
import SwiftUI

import NaverThirdPartyLogin

import AppFoundation
import UIComponent

struct NaverSignInButtonView: View {
 
  @ObservedObject var signInModelData: SignInModelData
  @Binding var error: MercuryError?
 
 public var body: some View {
   Button {
     Task {
       do {
         try await signInModelData.oauthSignIn(.naver)
       } catch let error as MercuryError {
         self.error = error
       }
     }
   } label: {
     HStack {
       Image(asset: UIComponentAsset.Images.naverStandard)
         .resizable()
         .aspectRatio(contentMode: .fit)
     }
     .frame(width: 200, height: 50)
     .clipShape(RoundedRectangle(cornerRadius: 8))
     .padding()
   }
 }
}
