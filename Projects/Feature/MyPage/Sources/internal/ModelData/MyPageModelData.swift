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
  private var mypageUsecase: MyPageUsecasable
  
  // MARK: - life cycle
  
  init(mypageUsecase: MyPageUsecasable) {
    self.mypageUsecase = mypageUsecase
  }
  
  func fetchProfile() async throws {
    do {
      let userProfile = try await mypageUsecase.fetchUserProfile()
      self.userProfile = userProfile
    } catch {
      throw error
    }
  }
  
  func openMail() async {
    let recipient = L10n.mypageSlugEmailAddress // 받는 사람
    let title = L10n.mypageChatTitle            // 제목
    let body = L10n.mypageChatBody              // 본문
    
    Task {
      try await self.mypageUsecase.openMail(
        recipent: recipient,
        title: title,
        body: body
      )
    }
  }
}

