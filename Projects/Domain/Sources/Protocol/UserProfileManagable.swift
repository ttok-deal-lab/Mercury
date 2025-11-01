//
//  UserProfileManagable.swift
//  Domain
//
//  Created by 최수훈 on 10/30/25.
//

import Combine

public protocol UserProfileManagable {
  var userProfileStream: CurrentValueSubject<UserProfileInfo?, Never> { get }
  
  func setUserProfile(_ profile: UserProfileInfo?)
}
