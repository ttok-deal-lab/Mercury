//
//  DeeplinkHandlable.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//

import Foundation

public protocol DeeplinkHandlable {
  func handle(url: URL) -> Bool
}
