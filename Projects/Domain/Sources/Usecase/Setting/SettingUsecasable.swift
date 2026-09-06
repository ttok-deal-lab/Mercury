//
//  SettingUsecasable.swift
//  Domain
//
//  Created by 최수훈 on 1/2/26.
//

import Foundation

public protocol SettingUsecasable {
  func signOut() async throws
  func logout() async throws
}
