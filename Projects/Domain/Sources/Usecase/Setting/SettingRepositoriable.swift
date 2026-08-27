//
//  SettingRepositoriable.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/2/26.
//
import Foundation

public protocol SettingRepositoriable {
  func signOut() async throws
  func logout() async throws
}
