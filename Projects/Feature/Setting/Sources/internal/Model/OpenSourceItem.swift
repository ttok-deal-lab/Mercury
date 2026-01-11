//
//  OpenSourceItem.swift
//  Setting
//
//  Created by 최수훈 on 1/7/26.
//

import Foundation
import SwiftUI

struct OpenSourceItem: Identifiable, Hashable {
  let id = UUID()
  let title: String
  let licenseContent: String
}


