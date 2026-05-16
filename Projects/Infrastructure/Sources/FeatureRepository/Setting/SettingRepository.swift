//
//  SettingRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/2/26.
//

import Foundation

import AppFoundation
import Domain

public class SettingRepository: SettingRepositoriable {
  
  private var signininformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  public init() { }
  public func signOut() async throws {
    
    guard let userID = signininformationManager.userInfo?.id else {
      throw MercuryError(.notFoundUser)
    }
    try await AuthAPI.signOut(userID: userID)
      .request()
  }

  
}
