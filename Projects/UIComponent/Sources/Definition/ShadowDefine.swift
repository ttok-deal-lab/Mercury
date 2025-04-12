//
//  ShadowDefine.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import Foundation

public enum ShadowDefine {
  case shadowLow
  case shadowMediumLow
  case shadowMedium
  case shadowHigh
  case shadowHighest
  
  var opacity: CGFloat {
    switch self {
    case .shadowLow:
      0.04
    case .shadowMediumLow:
      0.04
    case .shadowMedium:
      0.08
    case .shadowHigh:
      0.1
    case .shadowHighest:
      0.16
    }
  }
  
  var yDirection: CGFloat {
    switch self {
    case .shadowLow:
      2
    case .shadowMediumLow:
      2
    case .shadowMedium:
      2
    case .shadowHigh:
      4
    case .shadowHighest:
      8
    }
  }
  
  var xDirection: CGFloat {
    .zero
  }
  
  var blur: CGFloat {
    switch self {
    case .shadowLow:
      4
    case .shadowMediumLow:
      16
    case .shadowMedium:
      20
    case .shadowHigh:
      32
    case .shadowHighest:
      32
    }
  }
}
