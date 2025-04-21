//
//  MercuryFont.swift
//  UIComponent
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

public enum MercuryFont {
  case display
  
  case headingLargeBold
  case headingMediumBold
  case headingSmallBold
  case headingMiniBold
  
  case titleLargeBold
  case titleLargeMedium
  case titleMediumBold
  case titleMediumMedium
  
  case bodyLargeBold
  case bodyLargeMedium
  case bodyLargeRegular
  case bodyMediumBold
  case bodyMediumMedium
  case bodyMediumRegular
  case bodySmallBold
  case bodySmallMedium
  case bodySmallRegular
  case bodyMiniBold
  case bodyMiniMedium
  case bodyMiniRegular
  case bodyMicroBold
  case bodyMicroMedium
  case bodyMicroRegular
  
  case captionLargeMedium
  case captionMediumMedium
}

extension MercuryFont {
  var font: FontConvertible {
    switch self {
    case .bodyMiniBold,
        .bodyLargeBold,
        .bodyMicroBold,
        .bodySmallBold,
        .bodyMediumBold,
        .titleLargeBold,
        .headingMiniBold,
        .titleMediumBold,
        .headingLargeBold,
        .headingSmallBold,
        .headingMediumBold:
      return FontFamily.Pretendard.bold
    case .bodyMiniMedium,
        .bodyLargeMedium,
        .bodyMicroMedium,
        .bodySmallMedium,
        .titleLargeMedium,
        .titleMediumMedium,
        .bodyMediumMedium,
        .captionLargeMedium,
        .captionMediumMedium:
      return FontFamily.Pretendard.medium
    case .display,
        .bodyMiniRegular,
        .bodyLargeRegular,
        .bodyMicroRegular,
        .bodySmallRegular,
        .bodyMediumRegular:
      return FontFamily.Pretendard.regular
    }
  }
  
  var size: CGFloat {
    switch self {
    case .display:
      return 56
    case .headingLargeBold:
      return 32
    case .headingMediumBold:
      return 28
    case .headingSmallBold:
      return 24
    case .headingMiniBold:
      return 22
    case .titleLargeBold,
        .titleLargeMedium:
      return 20
    case .titleMediumBold,
        .titleMediumMedium:
      return 18
    case .bodyLargeBold,
        .bodyLargeMedium,
        .bodyLargeRegular:
      return 17
    case .bodyMediumBold,
        .bodyMediumMedium,
        .bodyMediumRegular:
      return 16
    case .bodySmallBold,
        .bodySmallMedium,
        .bodySmallRegular:
      return 15
    case .bodyMiniBold,
        .bodyMiniMedium,
        .bodyMiniRegular:
      return 14
    case .bodyMicroBold,
        .bodyMicroMedium,
        .bodyMicroRegular:
      return 13
    case .captionLargeMedium,
        .captionMediumMedium:
      return 11
    }
  }
  
  var lineHeight: CGFloat {
    switch self {
    case .display:
      return 68
    case .headingLargeBold:
      return 40
    case .headingMediumBold:
      return 36
    case .headingSmallBold:
      return 32
    case .headingMiniBold:
      return 30
    case .titleLargeBold,
        .titleLargeMedium:
      return 26
    case .titleMediumBold,
        .titleMediumMedium,
        .bodyLargeBold,
        .bodyLargeMedium,
        .bodyLargeRegular:
      return 24
    case .bodyMediumBold,
        .bodyMediumMedium,
        .bodyMediumRegular:
      return 22
    case .bodySmallBold,
        .bodySmallMedium,
        .bodySmallRegular:
      return 20
    case .bodyMiniBold,
        .bodyMiniMedium,
        .bodyMiniRegular,
        .bodyMicroBold,
        .bodyMicroMedium,
        .bodyMicroRegular:
      return 18
    case .captionLargeMedium,
        .captionMediumMedium:
      return 14
    }
  }
}
