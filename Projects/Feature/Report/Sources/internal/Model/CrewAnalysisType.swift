//
//  CrewAnalysisType.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import Foundation

import UIComponent

enum CrewAnalysisType: CaseIterable, Hashable {
  case commercial
  case infra
  case price
  case school
  
  var title: String {
    switch self {
    case .commercial: return L10n.reportCrewCreateAnalysisCommercial
    case .infra: return L10n.reportCrewCreateAnalysisInfra
    case .price: return L10n.reportCrewCreateAnalysisPrice
    case .school: return L10n.reportCrewCreateAnalysisSchool
    }
  }
}
