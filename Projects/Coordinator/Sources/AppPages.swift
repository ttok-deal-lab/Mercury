//
//  AppPages.swift
//  MercuryApp
//
//  Created by 송하민 on 10/5/24.
//

import Foundation

public enum AppPage: String, Hashable, Identifiable, CaseIterable {
  
  public var id: String {
    self.rawValue
  }
  
  case tutorialIntro
  case tutorialSelectionCategory
  case tutorialSelectionRegion
  case map
}
