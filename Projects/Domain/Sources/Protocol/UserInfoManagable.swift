//
//  SignInUserInformable.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine

public protocol UserInfoManagable {
  var userInfoStream: CurrentValueSubject<UserInformation?, Never> { get }
  
  func setUserInfo(_ info: UserInformation?)
}
