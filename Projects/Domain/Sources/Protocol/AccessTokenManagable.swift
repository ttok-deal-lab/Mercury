//
//  SignInInformable.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine

public protocol AccessTokenManagable {
  var tokenInfoStream: CurrentValueSubject<UserAccessToken?, Never> { get }
  
  func setAccessToken(_ accessToken: UserAccessToken?)
  func removeAccessToken()
}


