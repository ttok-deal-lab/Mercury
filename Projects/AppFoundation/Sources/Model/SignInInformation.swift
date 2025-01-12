//
//  SignInToken.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

public struct SignInInformation {
  var signInUser: SignInUserInfo
  var signInToken: SignInTokenInfo
}

public struct SignInUserInfo {
  let id: Int
  let email: String
  let name: String
  let provider: String
  let status: String
}

public struct SignInTokenInfo {
  let accessToken: String
  let refreshToken: String
}
