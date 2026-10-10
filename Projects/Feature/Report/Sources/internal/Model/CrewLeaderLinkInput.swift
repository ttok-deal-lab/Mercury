//
//  CrewLeaderLinkInput.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import Foundation

struct CrewLeaderLinkInput: Identifiable, Hashable {
  let id: UUID
  var url: String
  
  init(id: UUID = UUID(), url: String = "") {
    self.id = id
    self.url = url
  }
}
