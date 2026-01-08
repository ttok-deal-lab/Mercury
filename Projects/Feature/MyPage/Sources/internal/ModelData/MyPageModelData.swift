//
//  MyPageModelData.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import Combine

import AppFoundation
import Domain
import UIComponent
import Router


@Observable
final class MyPageModelData {
  
  // MARK: - internal property
  
  var userProfile: UserProfileInfo?
  
  // MARK: - private property
  private var userProfileUsecasable: MyPageUsecasable
  
  // MARK: - life cycle
  
  init(userProfileUsecasable: MyPageUsecasable) {
    self.userProfileUsecasable = userProfileUsecasable
  }
  
  func fetchProfile() async throws {
    do {
      let userProfile = try await userProfileUsecasable.fetchUserProfile()
      self.userProfile = userProfile
    } catch {
      throw error
    }
  }
  
  func openMail() {
    let recipient = L10n.mypageSlugEmailAddress // 받는 사람
    let title = L10n.mypageChatTitle            // 제목
    let body = L10n.mypageChatBody              // 본문
    
    var components = URLComponents()
    components.scheme = "googlegmail"
    components.path = "/co"
    components.queryItems = [
      URLQueryItem(name: "to", value: recipient),
      URLQueryItem(name: "subject", value: title),
      URLQueryItem(name: "body", value: body)
    ]
    
    guard let gmailUrl = components.url else { return }
    
    if UIApplication.shared.canOpenURL(gmailUrl) {
      UIApplication.shared.open(gmailUrl)
    } else {
      // Gmail이 없으면 '기본 메일 앱'으로 Fallback (mailto:)
      if let mailtoUrl = URL(string: "mailto:\(recipient)") {
        if UIApplication.shared.canOpenURL(mailtoUrl) {
          UIApplication.shared.open(mailtoUrl)
        } else {
          MercuryAlert.shared
            .present(
              type:
                  .confirmable(
                    information: AlertConfirmInformation(
                      title: "메일을 보낼 수 있는 앱이 없습니다.",
                      description: "",
                      confirmButtonTitle: L10n.commonConfirm,
                      onConfirm: {
                        
                      }
                    )
                  )
            )
        }
      }
    }
  }
}

