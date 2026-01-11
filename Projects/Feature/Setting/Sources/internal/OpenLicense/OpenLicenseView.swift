//
//  OpenLicenseView.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import SwiftUI

import UIComponent
import Router

struct OpenLicenseView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: OpenLicenseModelData
  
  init() {
    self.modelData = OpenLicenseModelData()
  }
  
  var body: some View {
    VStack {
      MercuryNavigationBar() {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      ScrollView {
        ForEach(modelData.licenses, id: \.self) { item in
          Text("""
            # ==============================
            
            \(item.title)
            
            \(item.licenseContent)
            """)
          .foregroundStyle(Asset.Colors.neutral.color)
        }
      }
      .padding(.horizontal, 20)
    }
    .navigationBarBackButtonHidden()
    .onLoad {
      Task {
        await modelData.loadLicenses()
      }
    }
    
    Spacer()
  }
}
