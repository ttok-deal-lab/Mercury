//
//  MailManagerable.swift
//  Domain
//
//  Created by 최수훈 on 1/9/26.
//

import Foundation

public protocol MailManagerable {
  func openMail(recipient: String, title: String, body: String)
}
