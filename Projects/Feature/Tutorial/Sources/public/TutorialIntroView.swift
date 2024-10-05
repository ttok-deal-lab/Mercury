//
//  TutorialIntro.swift
//  Tutorial
//
//  Created by 송하민 on 10/4/24.
//

import SwiftUI
import Foundation

import Coordinator
import AppFoundation
import UIComponent

public struct TutorialIntroView: View {
  
  private enum TutorialPageType {
    case welcome
    case easyToUse
    case done
  }
  
  @State private var currentPageType: TutorialPageType = .welcome
  @State private var isDoneIntro: Bool = false
  
  public init() { }
  
  public var body: some View {
    TabView(selection: $currentPageType) {
      
      tutorialPage(
        image: UIComponentAsset.Images.smililingKiss.swiftUIImage,
        description: "안녕하세요! 쉬운 경매 똑션입니다. 무슨말을 적어야할지 모르겠어요"
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .tag(TutorialPageType.welcome)
      
      tutorialPage(
        image: UIComponentAsset.Images.thinking.swiftUIImage,
        description: "여기에 튜토리얼에 알맞는 문장이 있으면 좋을 것 같아요! 아님말고"
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .tag(TutorialPageType.easyToUse)
      
      tutorialPage(
        image: UIComponentAsset.Images.sunglasses.swiftUIImage,
        description: "이제 관심물건을 설정하러갈건데 선글라스가 멋져보여요 히히!"
      )
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .tag(TutorialPageType.done)
      
    }
    .tabViewStyle(.page)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    
    MQButton(
      title: self.currentPageType != .done ? "다음" : "관심물건 설정하러 가기",
      font: .headline,
      backgroundColor: .black,
      foregroundColor: .white,
      action: {
        withAnimation {
          if currentPageType == .welcome {
            currentPageType = .easyToUse
          } else if currentPageType == .easyToUse {
            currentPageType = .done
          }
        }
      })
    .padding(.top, 20)
  }
  
  
  @ViewBuilder
  private func tutorialPage(image: Image, description: String) -> some View {
    VStack {
      Spacer()
      image
        .resizable()
        .frame(width: 200, height: 200)
      
      Spacer()
      Text(description)
        .multilineTextAlignment(.center)
        .font(.title2)
      Spacer()
    }
    
  }
  
}

#Preview {
  TutorialIntroView()
}
