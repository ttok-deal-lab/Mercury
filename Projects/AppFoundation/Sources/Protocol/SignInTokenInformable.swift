//
//  SignInInformable.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation
import Combine

public protocol SignInTokenInformable {
  var tokenInfo: CurrentValueSubject<SignInTokenInfo?, Never> { get }
}


