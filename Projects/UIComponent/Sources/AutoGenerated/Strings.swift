// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// 매물번호 %@
  public static func auctionDetailSalesNumber(_ p1: Any) -> String {
    return L10n.tr("Localizable", "auction_detail_sales_number", String(describing: p1), fallback: "매물번호 %@")
  }
  /// 경매상태
  public static let auctionFilterAuctionStatus = L10n.tr("Localizable", "auction_filter_auction_status", fallback: "경매상태")
  /// 낙찰
  public static let auctionFilterBidWon = L10n.tr("Localizable", "auction_filter_bidWon", fallback: "낙찰")
  /// 건물용도
  public static let auctionFilterBuildingUsage = L10n.tr("Localizable", "auction_filter_building_usage", fallback: "건물용도")
  /// %1$@ 외 %2$@
  public static func auctionFilterMultiSelect(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "auction_filter_multi_select", String(describing: p1), String(describing: p2), fallback: "%1$@ 외 %2$@")
  }
  /// 가격
  public static let auctionFilterPrice = L10n.tr("Localizable", "auction_filter_price", fallback: "가격")
  /// 임장보고서가 존재해 정확한 정보를 확인할 수 있어요.
  public static let auctionIntroduceCertifiedListingDescription = L10n.tr("Localizable", "auction_introduce_certified_listing_description", fallback: "임장보고서가 존재해 정확한 정보를 확인할 수 있어요.")
  /// 인증매물
  public static let auctionIntroduceCertifiedListingTitleA = L10n.tr("Localizable", "auction_introduce_certified_listing_title_A", fallback: "인증매물")
  /// 이란
  public static let auctionIntroduceCertifiedListingTitleB = L10n.tr("Localizable", "auction_introduce_certified_listing_title_B", fallback: "이란")
  /// 상품 
  public static let auctionItem = L10n.tr("Localizable", "auction_item", fallback: "상품 ")
  /// 기일 임박 순
  public static let auctionSortByImpendingDueDate = L10n.tr("Localizable", "auction_sort_by_impending_due_date", fallback: "기일 임박 순")
  /// 최신 등록순
  public static let auctionSortByLatestRegistration = L10n.tr("Localizable", "auction_sort_by_latest_registration", fallback: "최신 등록순")
  /// 유찰 적은 순
  public static let auctionSortByLessBidding = L10n.tr("Localizable", "auction_sort_by_less_bidding", fallback: "유찰 적은 순")
  /// 관심 많은 순
  public static let auctionSortByMostInterested = L10n.tr("Localizable", "auction_sort_by_most_interested", fallback: "관심 많은 순")
  /// 가격 높은 순
  public static let auctionSortByPriceHigher = L10n.tr("Localizable", "auction_sort_by_price_higher", fallback: "가격 높은 순")
  /// 가격 낮은 순
  public static let auctionSortByPriceLower = L10n.tr("Localizable", "auction_sort_by_price_lower", fallback: "가격 낮은 순")
  /// 앱 버전
  public static let commonAppVersion = L10n.tr("Localizable", "common_app_version", fallback: "앱 버전")
  /// 취소
  public static let commonCancel = L10n.tr("Localizable", "common_cancel", fallback: "취소")
  /// 인증매물
  public static let commonCertifiedAuction = L10n.tr("Localizable", "common_certified_auction", fallback: "인증매물")
  /// 닫기
  public static let commonClose = L10n.tr("Localizable", "common_close", fallback: "닫기")
  /// 확인
  public static let commonConfirm = L10n.tr("Localizable", "common_confirm", fallback: "확인")
  /// 유찰 %@회
  public static func commonFailedBidCount(_ p1: Any) -> String {
    return L10n.tr("Localizable", "common_failed_bid_count", String(describing: p1), fallback: "유찰 %@회")
  }
  /// 아니오
  public static let commonNo = L10n.tr("Localizable", "common_no", fallback: "아니오")
  /// %@원
  public static func commonWon(_ p1: Any) -> String {
    return L10n.tr("Localizable", "common_won", String(describing: p1), fallback: "%@원")
  }
  /// 네
  public static let commonYes = L10n.tr("Localizable", "common_yes", fallback: "네")
  /// 전체
  public static let homeDefaultArea = L10n.tr("Localizable", "home_default_area", fallback: "전체")
  /// 관심 내역이 없어요.
  public static let interestViewNone = L10n.tr("Localizable", "interest_view_none", fallback: "관심 내역이 없어요.")
  /// 문의하실 내용을 입력해주세요.
  public static let mypageChatBody = L10n.tr("Localizable", "mypage_chat_body", fallback: "문의하실 내용을 입력해주세요.")
  /// [민달팽이] 문의 메일
  public static let mypageChatTitle = L10n.tr("Localizable", "mypage_chat_title", fallback: "[민달팽이] 문의 메일")
  /// 애플로 로그인
  public static let mypageLoginApple = L10n.tr("Localizable", "mypage_login_apple", fallback: "애플로 로그인")
  /// 구글로 로그인
  public static let mypageLoginGoogle = L10n.tr("Localizable", "mypage_login_google", fallback: "구글로 로그인")
  /// 카카오로 로그인
  public static let mypageLoginKakao = L10n.tr("Localizable", "mypage_login_kakao", fallback: "카카오로 로그인")
  /// 네이버로 로그인
  public static let mypageLoginNaver = L10n.tr("Localizable", "mypage_login_naver", fallback: "네이버로 로그인")
  /// slugdeveloper@gmail.com
  public static let mypageSlugEmailAddress = L10n.tr("Localizable", "mypage_slug_email_address", fallback: "slugdeveloper@gmail.com")
  /// 회원 이용약관
  public static let settingAgreement = L10n.tr("Localizable", "setting_agreement", fallback: "회원 이용약관")
  /// 로그아웃 하시겠어요?
  public static let settingAlertLogout = L10n.tr("Localizable", "setting_alert_logout", fallback: "로그아웃 하시겠어요?")
  /// 1:1 문의
  public static let settingChat = L10n.tr("Localizable", "setting_chat", fallback: "1:1 문의")
  /// 로그인
  public static let settingLogin = L10n.tr("Localizable", "setting_login", fallback: "로그인")
  /// 로그아웃
  public static let settingLogout = L10n.tr("Localizable", "setting_logout", fallback: "로그아웃")
  /// 알림
  public static let settingNoti = L10n.tr("Localizable", "setting_noti", fallback: "알림")
  /// 알림 수신에 동의했어요.
  public static let settingNotiAgree = L10n.tr("Localizable", "setting_noti_agree", fallback: "알림 수신에 동의했어요.")
  /// 알림 수신을 거부했어요.
  public static let settingNotiDecline = L10n.tr("Localizable", "setting_noti_decline", fallback: "알림 수신을 거부했어요.")
  /// 중요한 정보를 알림으로 전달드려요.
  public static let settingNotiDescription = L10n.tr("Localizable", "setting_noti_description", fallback: "중요한 정보를 알림으로 전달드려요.")
  /// 알림 설정 관리
  public static let settingNotificationManage = L10n.tr("Localizable", "setting_notification_manage", fallback: "알림 설정 관리")
  /// 오픈소스 라이선스 보기
  public static let settingOpenLicense = L10n.tr("Localizable", "setting_open_license", fallback: "오픈소스 라이선스 보기")
  /// 개인정보처리방침
  public static let settingPrivacyPolicy = L10n.tr("Localizable", "setting_privacy policy", fallback: "개인정보처리방침")
  /// 최근 본 매물이 없어요.
  public static let settingRecentViewNone = L10n.tr("Localizable", "setting_recent_view_none", fallback: "최근 본 매물이 없어요.")
  /// 최근 본 매물
  public static let settingRecentViewSales = L10n.tr("Localizable", "setting_recent_view_sales", fallback: "최근 본 매물")
  /// 서비스 운영정책
  public static let settingServiceOperationPolicy = L10n.tr("Localizable", "setting_service_operation_policy", fallback: "서비스 운영정책")
  /// 탈퇴하기
  public static let settingSignout = L10n.tr("Localizable", "setting_signout", fallback: "탈퇴하기")
  /// 서비스 약관
  public static let settingTerms = L10n.tr("Localizable", "setting_terms", fallback: "서비스 약관")
  /// 업데이트하기
  public static let settingUpdate = L10n.tr("Localizable", "setting_update", fallback: "업데이트하기")
  /// 탈퇴 전 안내 사항을 모두 확인했어요.
  public static let signoutCheckComment = L10n.tr("Localizable", "signout_check_comment", fallback: "탈퇴 전 안내 사항을 모두 확인했어요.")
  /// 고객님의 개인정보는 개인정보처리 방침에 따라 완전하게 삭제돼요.
  public static let signoutDescription1 = L10n.tr("Localizable", "signout_description1", fallback: "고객님의 개인정보는 개인정보처리 방침에 따라 완전하게 삭제돼요.")
  /// 사용하신 아이디는 다시 사용할 수 없어요.
  public static let signoutDescription2 = L10n.tr("Localizable", "signout_description2", fallback: "사용하신 아이디는 다시 사용할 수 없어요.")
  /// 탈퇴하시나요?
  /// 탈퇴 전 안내 사항을 반드시 확인해주세요.
  public static let signoutTitle = L10n.tr("Localizable", "signout_title", fallback: "탈퇴하시나요?\n탈퇴 전 안내 사항을 반드시 확인해주세요.")
  /// 홈
  public static let tabHome = L10n.tr("Localizable", "tab_home", fallback: "홈")
  /// 관심
  public static let tabInterest = L10n.tr("Localizable", "tab_interest", fallback: "관심")
  /// 설정
  public static let tabSetting = L10n.tr("Localizable", "tab_setting", fallback: "설정")
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
