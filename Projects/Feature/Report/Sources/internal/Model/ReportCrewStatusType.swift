//
//  ReportCrewStatusType.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import UIComponent

enum ReportCrewStatusType {
  case recruiting
  case ongoing
  case closed
  
  var title: String {
    switch self {
    case .recruiting: return L10n.reportCrewStatusRecruiting
    case .ongoing: return L10n.reportCrewStatusOngoing
    case .closed: return L10n.reportCrewStatusClosed
    }
  }
  
  var textColor: Color {
    switch self {
    case .recruiting: return Asset.Colors.primary.color
    case .ongoing: return Asset.Colors.positive.color
    case .closed: return Asset.Colors.neutralSubtler.color
    }
  }
  
  var backgroundColor: Color {
    switch self {
    case .recruiting: return Asset.Colors.primaryLight.color
    case .ongoing: return Asset.Colors.positiveLight.color
    case .closed: return Asset.Colors.neutralWeak.color
    }
  }
}
