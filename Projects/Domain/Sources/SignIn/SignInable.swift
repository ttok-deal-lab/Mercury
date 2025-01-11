//
//  SignInable.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation

public protocol SignInable {
  func signIn() async -> Result<SignInToken, MercuryError>
}
