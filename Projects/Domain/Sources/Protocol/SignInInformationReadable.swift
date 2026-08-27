//
//  SignInInformable.swift
//  Domain
//
//  Created by 송하민 on 4/25/25.
//

public protocol SignInInformationReadable {
  var accessToken: UserAccessToken? { get }
  var userInfo: UserInformation? { get }
}
