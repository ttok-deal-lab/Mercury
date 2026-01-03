//
//  TermsType.swift
//  Domain
//
//  Created by 최수훈 on 1/3/26.
//

import Foundation

import AppFoundation
import UIComponent

public enum TermsType: CaseIterable {
  case memberAgreement
  case privacyPolicy
  case servicePolicy
  
  public var displayTitle: String {
    switch self {
    case .memberAgreement:
      L10n.settingAgreement
    case .privacyPolicy:
      L10n.settingPrivacyPolicy
    case .servicePolicy:
      L10n.settingServiceOperationPolicy
    }
  }
  
  public var webURL: URL? {
    switch self {
    case .memberAgreement:
      URL(string: PolicyURL.memberAgreement)
    case .privacyPolicy:
      URL(string: PolicyURL.privacyPolicy)
    case .servicePolicy:
      URL(string: PolicyURL.servicePolicy)
    }
  }
}
