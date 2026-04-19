// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// 감정가
  public static let auctionDetailAppraisalPrice = L10n.tr("Localizable", "auction_detail_appraisal_price", fallback: "감정가")
  /// 감정가대비
  public static let auctionDetailAppraisalRatio = L10n.tr("Localizable", "auction_detail_appraisal_ratio", fallback: "감정가대비")
  /// 감정가와 동일
  public static let auctionDetailAppraisalSame = L10n.tr("Localizable", "auction_detail_appraisal_same", fallback: "감정가와 동일")
  /// 경매 정보
  public static let auctionDetailAuctionInfoTitle = L10n.tr("Localizable", "auction_detail_auction_info_title", fallback: "경매 정보")
  /// 일반입찰
  public static let auctionDetailBidGeneral = L10n.tr("Localizable", "auction_detail_bid_general", fallback: "일반입찰")
  /// 제한입찰
  public static let auctionDetailBidLimited = L10n.tr("Localizable", "auction_detail_bid_limited", fallback: "제한입찰")
  /// 입찰방식
  public static let auctionDetailBidType = L10n.tr("Localizable", "auction_detail_bid_type", fallback: "입찰방식")
  /// 사건번호: %@
  public static func auctionDetailCaseNumber(_ p1: Any) -> String {
    return L10n.tr("Localizable", "auction_detail_case_number", String(describing: p1), fallback: "사건번호: %@")
  }
  /// 매각 D-%@
  public static func auctionDetailChipSaleDday(_ p1: Any) -> String {
    return L10n.tr("Localizable", "auction_detail_chip_sale_dday", String(describing: p1), fallback: "매각 D-%@")
  }
  /// 매각 종료
  public static let auctionDetailChipSaleEnded = L10n.tr("Localizable", "auction_detail_chip_sale_ended", fallback: "매각 종료")
  /// 오늘 매각
  public static let auctionDetailChipSaleToday = L10n.tr("Localizable", "auction_detail_chip_sale_today", fallback: "오늘 매각")
  /// 낙찰 완료
  public static let auctionDetailChipSold = L10n.tr("Localizable", "auction_detail_chip_sold", fallback: "낙찰 완료")
  /// 담당
  public static let auctionDetailCourtCharge = L10n.tr("Localizable", "auction_detail_court_charge", fallback: "담당")
  /// 관할법원
  public static let auctionDetailCourtJurisdiction = L10n.tr("Localizable", "auction_detail_court_jurisdiction", fallback: "관할법원")
  /// 배당종기일
  public static let auctionDetailHistoryDistributionDeadline = L10n.tr("Localizable", "auction_detail_history_distribution_deadline", fallback: "배당종기일")
  /// 현황조사일
  public static let auctionDetailHistoryInvestigationDate = L10n.tr("Localizable", "auction_detail_history_investigation_date", fallback: "현황조사일")
  /// 최신
  public static let auctionDetailHistoryLatest = L10n.tr("Localizable", "auction_detail_history_latest", fallback: "최신")
  /// 최저매각
  public static let auctionDetailHistoryMinPrice = L10n.tr("Localizable", "auction_detail_history_min_price", fallback: "최저매각")
  /// 결과
  public static let auctionDetailHistoryResult = L10n.tr("Localizable", "auction_detail_history_result", fallback: "결과")
  /// 경매개시일
  public static let auctionDetailHistoryStartDate = L10n.tr("Localizable", "auction_detail_history_start_date", fallback: "경매개시일")
  /// 경매 히스토리
  public static let auctionDetailHistoryTitle = L10n.tr("Localizable", "auction_detail_history_title", fallback: "경매 히스토리")
  /// 목록 상세내역
  public static let auctionDetailListDetail = L10n.tr("Localizable", "auction_detail_list_detail", fallback: "목록 상세내역")
  /// 위치 정보를 불러오는 중이에요
  public static let auctionDetailLoadingLocation = L10n.tr("Localizable", "auction_detail_loading_location", fallback: "위치 정보를 불러오는 중이에요")
  /// 최저매각가격
  public static let auctionDetailMinSalePrice = L10n.tr("Localizable", "auction_detail_min_sale_price", fallback: "최저매각가격")
  /// 표시할 위치 정보를 찾지 못했어요
  public static let auctionDetailNoLocation = L10n.tr("Localizable", "auction_detail_no_location", fallback: "표시할 위치 정보를 찾지 못했어요")
  /// 물건 위치
  public static let auctionDetailPropertyLocation = L10n.tr("Localizable", "auction_detail_property_location", fallback: "물건 위치")
  /// 접수마감
  public static let auctionDetailReceptionDeadline = L10n.tr("Localizable", "auction_detail_reception_deadline", fallback: "접수마감")
  /// 취소
  public static let auctionDetailResultCanceled = L10n.tr("Localizable", "auction_detail_result_canceled", fallback: "취소")
  /// 유찰
  public static let auctionDetailResultFailed = L10n.tr("Localizable", "auction_detail_result_failed", fallback: "유찰")
  /// 연기
  public static let auctionDetailResultPostponed = L10n.tr("Localizable", "auction_detail_result_postponed", fallback: "연기")
  /// 낙찰
  public static let auctionDetailResultSold = L10n.tr("Localizable", "auction_detail_result_sold", fallback: "낙찰")
  /// 매각기일
  public static let auctionDetailSaleDate = L10n.tr("Localizable", "auction_detail_sale_date", fallback: "매각기일")
  /// 매각 정보
  public static let auctionDetailSaleInfoTitle = L10n.tr("Localizable", "auction_detail_sale_info_title", fallback: "매각 정보")
  /// 매각장소
  public static let auctionDetailSaleLocation = L10n.tr("Localizable", "auction_detail_sale_location", fallback: "매각장소")
  /// 매각비고
  public static let auctionDetailSaleNote = L10n.tr("Localizable", "auction_detail_sale_note", fallback: "매각비고")
  /// 매각
  public static let auctionDetailSaleStatus = L10n.tr("Localizable", "auction_detail_sale_status", fallback: "매각")
  /// 매물번호 %@
  public static func auctionDetailSalesNumber(_ p1: Any) -> String {
    return L10n.tr("Localizable", "auction_detail_sales_number", String(describing: p1), fallback: "매물번호 %@")
  }
  /// 경매정보
  public static let auctionDetailTabAuctionInfo = L10n.tr("Localizable", "auction_detail_tab_auction_info", fallback: "경매정보")
  /// 권리분석
  public static let auctionDetailTabRightsAnalysis = L10n.tr("Localizable", "auction_detail_tab_rights_analysis", fallback: "권리분석")
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
  public static let auctionItem = L10n.tr("Localizable", "auction_item", fallback: "상품")
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
  /// 서울중앙지방법원
  public static let courtSeoulCentral = L10n.tr("Localizable", "court_seoul_central", fallback: "서울중앙지방법원")
  /// 서울동부지방법원
  public static let courtSeoulEastern = L10n.tr("Localizable", "court_seoul_eastern", fallback: "서울동부지방법원")
  /// 서울북부지방법원
  public static let courtSeoulNorthern = L10n.tr("Localizable", "court_seoul_northern", fallback: "서울북부지방법원")
  /// 서울남부지방법원
  public static let courtSeoulSouthern = L10n.tr("Localizable", "court_seoul_southern", fallback: "서울남부지방법원")
  /// 서울서부지방법원
  public static let courtSeoulWestern = L10n.tr("Localizable", "court_seoul_western", fallback: "서울서부지방법원")
  /// 문제가 발생했습니다.
  /// [error code: %@]
  public static func errorDefault(_ p1: Any) -> String {
    return L10n.tr("Localizable", "error_default", String(describing: p1), fallback: "문제가 발생했습니다.\n[error code: %@]")
  }
  /// 유효하지 않은 범위
  public static let errorInvalidStatusCode = L10n.tr("Localizable", "error_invalid_status_code", fallback: "유효하지 않은 범위")
  /// 로그인 되었습니다!
  public static let errorLoginSuccess = L10n.tr("Localizable", "error_login_success", fallback: "로그인 되었습니다!")
  /// 메일을 보낼 수 있는 앱이 없습니다.
  public static let errorNoMailApp = L10n.tr("Localizable", "error_no_mail_app", fallback: "메일을 보낼 수 있는 앱이 없습니다.")
  /// 에러
  public static let errorTitle = L10n.tr("Localizable", "error_title", fallback: "에러")
  /// 엑세스토큰 인증 실패
  public static let errorUnauthorized = L10n.tr("Localizable", "error_unauthorized", fallback: "엑세스토큰 인증 실패")
  /// 알 수 없는 오류
  public static let errorUnknown = L10n.tr("Localizable", "error_unknown", fallback: "알 수 없는 오류")
  /// 전체
  public static let homeDefaultArea = L10n.tr("Localizable", "home_default_area", fallback: "전체")
  /// 관심 내역이 없어요.
  public static let interestViewNone = L10n.tr("Localizable", "interest_view_none", fallback: "관심 내역이 없어요.")
  /// 아파트
  public static let itemTypeApartment = L10n.tr("Localizable", "item_type_apartment", fallback: "아파트")
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
  /// 애플
  public static let mypageProviderApple = L10n.tr("Localizable", "mypage_provider_apple", fallback: "애플")
  /// 구글
  public static let mypageProviderGoogle = L10n.tr("Localizable", "mypage_provider_google", fallback: "구글")
  /// 카카오
  public static let mypageProviderKakao = L10n.tr("Localizable", "mypage_provider_kakao", fallback: "카카오")
  /// 네이버
  public static let mypageProviderNaver = L10n.tr("Localizable", "mypage_provider_naver", fallback: "네이버")
  /// slugdeveloper@gmail.com
  public static let mypageSlugEmailAddress = L10n.tr("Localizable", "mypage_slug_email_address", fallback: "slugdeveloper@gmail.com")
  /// 인터넷 상태를 확인해주세요
  public static let networkDisconnectedCheck = L10n.tr("Localizable", "network_disconnected_check", fallback: "인터넷 상태를 확인해주세요")
  /// 인터넷 연결이 되면 바로 사용할 수 있어요
  public static let networkDisconnectedDescription = L10n.tr("Localizable", "network_disconnected_description", fallback: "인터넷 연결이 되면 바로 사용할 수 있어요")
  /// 인터넷 연결이 되지 않아요
  public static let networkDisconnectedTitle = L10n.tr("Localizable", "network_disconnected_title", fallback: "인터넷 연결이 되지 않아요")
  /// 구글로 로그인
  public static let onboardLoginGoogle = L10n.tr("Localizable", "onboard_login_google", fallback: "구글로 로그인")
  /// 카카오로 로그인
  public static let onboardLoginKakao = L10n.tr("Localizable", "onboard_login_kakao", fallback: "카카오로 로그인")
  /// 네이버로 로그인
  public static let onboardLoginNaver = L10n.tr("Localizable", "onboard_login_naver", fallback: "네이버로 로그인")
  /// 휴대폰 설정 > 앱 > 민들팽이
  public static let onboardPermissionChangePath = L10n.tr("Localizable", "onboard_permission_change_path", fallback: "휴대폰 설정 > 앱 > 민들팽이")
  /// 접근 권한 변경 안내
  public static let onboardPermissionChangeTitle = L10n.tr("Localizable", "onboard_permission_change_title", fallback: "접근 권한 변경 안내")
  /// 접근 권한은 서비스 사용 중 필요한 시점에 동의를 받고 있습니다. 허용하지 않을 경우에도 해당 기능 외 서비스는 이용할 수 있습니다.
  public static let onboardPermissionGuideDesc = L10n.tr("Localizable", "onboard_permission_guide_desc", fallback: "접근 권한은 서비스 사용 중 필요한 시점에 동의를 받고 있습니다. 허용하지 않을 경우에도 해당 기능 외 서비스는 이용할 수 있습니다.")
  /// 접근 권한 안내
  public static let onboardPermissionGuideTitle = L10n.tr("Localizable", "onboard_permission_guide_title", fallback: "접근 권한 안내")
  /// 위치
  public static let onboardPermissionLocation = L10n.tr("Localizable", "onboard_permission_location", fallback: "위치")
  /// 위치 및 부동산 찾기
  public static let onboardPermissionLocationDesc = L10n.tr("Localizable", "onboard_permission_location_desc", fallback: "위치 및 부동산 찾기")
  /// 알림
  public static let onboardPermissionNotification = L10n.tr("Localizable", "onboard_permission_notification", fallback: "알림")
  /// 알림 및 메시지 전송
  public static let onboardPermissionNotificationDesc = L10n.tr("Localizable", "onboard_permission_notification_desc", fallback: "알림 및 메시지 전송")
  /// 선택 권한
  public static let onboardPermissionOptional = L10n.tr("Localizable", "onboard_permission_optional", fallback: "선택 권한")
  /// 앱 사용을 위해
  /// 접근 권한을 허용해주세요.
  public static let onboardPermissionTitle = L10n.tr("Localizable", "onboard_permission_title", fallback: "앱 사용을 위해\n접근 권한을 허용해주세요.")
  /// 아파트
  public static let propertyTypeApartment = L10n.tr("Localizable", "property_type_apartment", fallback: "아파트")
  /// 건물
  public static let propertyTypeBuilding = L10n.tr("Localizable", "property_type_building", fallback: "건물")
  /// 주택
  public static let propertyTypeHousing = L10n.tr("Localizable", "property_type_housing", fallback: "주택")
  /// 토지
  public static let propertyTypeLand = L10n.tr("Localizable", "property_type_land", fallback: "토지")
  /// 오피스텔
  public static let propertyTypeOfficetel = L10n.tr("Localizable", "property_type_officetel", fallback: "오피스텔")
  /// 기타
  public static let propertyTypeOther = L10n.tr("Localizable", "property_type_other", fallback: "기타")
  /// 상점
  public static let propertyTypeShop = L10n.tr("Localizable", "property_type_shop", fallback: "상점")
  /// 빌라
  public static let propertyTypeVilla = L10n.tr("Localizable", "property_type_villa", fallback: "빌라")
  /// 소재지
  public static let rightsAddress = L10n.tr("Localizable", "rights_address", fallback: "소재지")
  /// 확정일자
  public static let rightsConfirmedDate = L10n.tr("Localizable", "rights_confirmed_date", fallback: "확정일자")
  /// 보증금
  public static let rightsDeposit = L10n.tr("Localizable", "rights_deposit", fallback: "보증금")
  /// 월세
  public static let rightsMonthlyRent = L10n.tr("Localizable", "rights_monthly_rent", fallback: "월세")
  /// 전입신고일
  public static let rightsMoveInDate = L10n.tr("Localizable", "rights_move_in_date", fallback: "전입신고일")
  /// 점유자 정보가 없습니다
  public static let rightsNoOccupant = L10n.tr("Localizable", "rights_no_occupant", fallback: "점유자 정보가 없습니다")
  /// 점유기간
  public static let rightsOccupationPeriod = L10n.tr("Localizable", "rights_occupation_period", fallback: "점유기간")
  /// 용도
  public static let rightsPurpose = L10n.tr("Localizable", "rights_purpose", fallback: "용도")
  /// 채무자
  public static let rightsRoleDebtor = L10n.tr("Localizable", "rights_role_debtor", fallback: "채무자")
  /// 소유자
  public static let rightsRoleOwner = L10n.tr("Localizable", "rights_role_owner", fallback: "소유자")
  /// 임차인
  public static let rightsRoleTenant = L10n.tr("Localizable", "rights_role_tenant", fallback: "임차인")
  /// 임차인
  public static let rightsTenantTitle = L10n.tr("Localizable", "rights_tenant_title", fallback: "임차인")
  /// 상업
  public static let rightsUseCommercial = L10n.tr("Localizable", "rights_use_commercial", fallback: "상업")
  /// 사무실
  public static let rightsUseOffice = L10n.tr("Localizable", "rights_use_office", fallback: "사무실")
  /// 주거
  public static let rightsUseResidential = L10n.tr("Localizable", "rights_use_residential", fallback: "주거")
  /// 전체삭제
  public static let searchDeleteAll = L10n.tr("Localizable", "search_delete_all", fallback: "전체삭제")
  /// 적용
  public static let searchFilterApply = L10n.tr("Localizable", "search_filter_apply", fallback: "적용")
  /// 지역 선택
  public static let searchFilterLocation = L10n.tr("Localizable", "search_filter_location", fallback: "지역 선택")
  /// 정렬
  public static let searchFilterSort = L10n.tr("Localizable", "search_filter_sort", fallback: "정렬")
  /// 검색어를 한 글자 이상 작성해주세요
  public static let searchMinLength = L10n.tr("Localizable", "search_min_length", fallback: "검색어를 한 글자 이상 작성해주세요")
  /// 검색 결과가 없어요
  public static let searchNoResult = L10n.tr("Localizable", "search_no_result", fallback: "검색 결과가 없어요")
  /// 경매 번호
  public static let searchPlaceholder1 = L10n.tr("Localizable", "search_placeholder1", fallback: "경매 번호")
  /// 주소 검색
  public static let searchPlaceholder2 = L10n.tr("Localizable", "search_placeholder2", fallback: "주소 검색")
  /// 최근 검색어
  public static let searchRecent = L10n.tr("Localizable", "search_recent", fallback: "최근 검색어")
  /// 최근 검색 내역이 없어요
  public static let searchRecentNone = L10n.tr("Localizable", "search_recent_none", fallback: "최근 검색 내역이 없어요")
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
  /// 상업
  public static let zoneCommercial = L10n.tr("Localizable", "zone_commercial", fallback: "상업")
  /// 전용주거
  public static let zoneExclusiveResidential = L10n.tr("Localizable", "zone_exclusive_residential", fallback: "전용주거")
  /// 일반주거
  public static let zoneGeneralResidential = L10n.tr("Localizable", "zone_general_residential", fallback: "일반주거")
  /// 공업
  public static let zoneIndustrial = L10n.tr("Localizable", "zone_industrial", fallback: "공업")
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
