// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// 임장보고서가 존재해 정확한 정보를 확인할 수 있어요.
  public static let auctionIntroduceCertifiedListingDescription = L10n.tr("Localizable", "auction_introduce_certified_listing_description", fallback: "임장보고서가 존재해 정확한 정보를 확인할 수 있어요.")
  /// 인증매물
  public static let auctionIntroduceCertifiedListingTitleA = L10n.tr("Localizable", "auction_introduce_certified_listing_title_A", fallback: "인증매물")
  /// 이란
  public static let auctionIntroduceCertifiedListingTitleB = L10n.tr("Localizable", "auction_introduce_certified_listing_title_B", fallback: "이란")
  /// 상품 
  public static let auctionItem = L10n.tr("Localizable", "auction_item", fallback: "상품 ")
  /// 최신 등록순
  public static let auctionSortByLatestRegistration = L10n.tr("Localizable", "auction_sort_by_latest_registration", fallback: "최신 등록순")
  /// 취소
  public static let commonCancel = L10n.tr("Localizable", "common_cancel", fallback: "취소")
  /// 닫기
  public static let commonClose = L10n.tr("Localizable", "common_close", fallback: "닫기")
  /// 확인
  public static let commonConfirm = L10n.tr("Localizable", "common_confirm", fallback: "확인")
  /// 아니오
  public static let commonNo = L10n.tr("Localizable", "common_no", fallback: "아니오")
  /// %@원
  public static func commonWon(_ p1: Any) -> String {
    return L10n.tr("Localizable", "common_won", String(describing: p1), fallback: "%@원")
  }
  /// 네
  public static let commonYes = L10n.tr("Localizable", "common_yes", fallback: "네")
  /// 서울 관악구
  public static let homeDefaultArea = L10n.tr("Localizable", "home_default_area", fallback: "서울 관악구")
  /// 로그인
  public static let settingLogin = L10n.tr("Localizable", "setting_login", fallback: "로그인")
  /// 로그아웃
  public static let settingLogout = L10n.tr("Localizable", "setting_logout", fallback: "로그아웃")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
