//
//  Joek.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public struct JokeInfo: Decodable {
  let category: String
  let type: String
  let setup: String?
  let delivery: String?
}
