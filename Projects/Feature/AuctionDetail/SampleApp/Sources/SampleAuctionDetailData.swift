//
//  SampleAuctionDetailData.swift
//  AuctionDetailSampleApp
//
//  실제 dev 서버(GET /v2/courts/sales/187, 2025타경51713) 응답을 그대로 옮긴 고정 데이터.
//  실 API 는 인증 토큰이 있어야 호출되므로(401), 받은 응답을 엔티티로 박아 화면을 미리본다.
//  - caseName "청산을위한형식적경매" → 미노출값이라 경매구분 카드는 "-" 로 표시된다.
//  - salesPictures 25장은 실제 응답에서 url 이 전부 null 이라 이미지가 없다(서버 상태 그대로).
//  - rightsAnalysis 는 서버가 (mock) 값으로 내려준다.
//

import Foundation

import Domain

enum SampleAuctionDetail {

  /// 미리보기 대상 경매 ID (187 / 2025타경51713)
  static let auctionID = 187

  static func make() -> AuctionDetail {
    AuctionDetail(
      id: auctionID,
      salesNumber: "2025타경51713",
      itemTypes: [.detachedHouse, .multiHousehold],
      appraisalPrice: 254_670_040,
      lowestSalesPrice: 203_736_000,
      bidType: .scheduledBid,
      salesDateTime: date(2026, 6, 15, 10),
      salesLocation: "입찰법정[제101호]",
      salesNote: "일괄매각",
      salesReceptionDate: date(2025, 7, 2, 12),
      salesOpenDate: date(2025, 7, 9, 12),
      distributionRequiredDeadlineDate: date(2025, 9, 29, 12),
      salesAddress: "서울특별시 강동구 천호동 173-62",
      salesCategories: ["HOUSING", "BUILDING", "RESIDENTIAL_BUILDING", "LAND", "LAND_DESIGNATION", "BUILDING_SITE"]
        .map(AuctionDetail.SalesCategory.init(rawValue:)),
      failBidCount: 1,
      zzimCount: 0,
      court: AuctionDetail.Court(
        code: AuctionDetail.Court.CourtCode(rawValue: "SEOUL_EAST_DISTRICT"),
        team: "경매4계"
      ),
      courtInfo: AuctionDetail.CourtInfo(
        code: "B000211",
        name: "SEOUL_EAST_DISTRICT",
        address: "서울특별시 송파구 법원로 101",
        latitude: 37.4834944551671,
        longitude: 127.119751590812
      ),
      salesDetails: salesDetails,
      salesPictures: salesPictures,
      salesBuildings: salesBuildings,
      salesItemDetails: salesItemDetails,
      conditionReport: AuctionDetail.ConditionReport(
        investigationDate: date(2025, 7, 21, 9),
        estateLeaseInfos: [],
        occupationRelations: [],
        occupationRelationReports: []
      ),
      appraisalDocumentUrl: URL(string: "https://ca.kapanet.or.kr/825B2D1A/001/EF403772/ACE20250714-34-5.pdf"),
      appraisalDocuments: [],
      nearbySalesStats: nearbySalesStats,
      soldOut: false,
      verified: true,
      salesBuildingName: "서울특별시 강동구 천호동 173-62 다가구주택",
      exclusiveArea: 0.0,
      caseName: "청산을위한형식적경매",
      creditorCount: 0,
      recentTransactionPrice: nil,   // 서버 sentinel(-999999999) → 데이터 없음
      recentTransactionDate: nil,    // 서버 sentinel("2026-99-99") → 데이터 없음
      rightsAnalysis: rightsAnalysis
    )
  }

  // MARK: - 기일 내역

  private static var salesDetails: [AuctionDetail.SalesDetail] {
    [
      AuctionDetail.SalesDetail(
        timeStamp: date(2026, 6, 22, 2),
        type: AuctionDetail.SalesDetail.SalesDetailType(rawValue: "SALE_DECISION"),
        location: "입찰법정[제101호]",
        leastSalesPrice: 203_736_000,
        result: .planned
      ),
      AuctionDetail.SalesDetail(
        timeStamp: date(2026, 6, 15, 10),
        type: AuctionDetail.SalesDetail.SalesDetailType(rawValue: "SALE"),
        location: "입찰법정[제101호]",
        leastSalesPrice: 203_736_000,
        result: .planned
      ),
      AuctionDetail.SalesDetail(
        timeStamp: date(2026, 4, 27, 10),
        type: AuctionDetail.SalesDetail.SalesDetailType(rawValue: "SALE"),
        location: "입찰법정[제101호]",
        leastSalesPrice: 254_670_040,
        result: .failedBid
      )
    ]
  }

  // MARK: - 사진 (실제 응답: 25장 모두 url == null)

  private static var salesPictures: [SalesPicture] {
    [1, 2, 3, 4, 5, 6, 7, 8, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28]
      .map { SalesPicture(sequence: $0, url: nil) }
  }

  // MARK: - 소재지 / 목록

  private static var salesBuildings: [AuctionDetail.SalesBuilding] {
    let address = AuctionDetail.SalesBuilding.Address(
      siDo: "서울특별시",
      gu: "강동구",
      dong: "천호동",
      ri: "",
      full: "서울특별시 강동구 천호동 173-62 "
    )
    return [
      AuctionDetail.SalesBuilding(
        address: address,
        detailAddress: "173-62",
        category: AuctionDetail.SalesBuilding.BuildingCategory(rawValue: "대지")
      ),
      AuctionDetail.SalesBuilding(
        address: address,
        detailAddress: "173-62",
        category: AuctionDetail.SalesBuilding.BuildingCategory(rawValue: "다가구주택")
      )
    ]
  }

  private static var salesItemDetails: [AuctionDetail.SalesItemDetail] {
    [
      AuctionDetail.SalesItemDetail(
        sequence: 1,
        type: AuctionDetail.SalesItemDetail.ItemDetailType(rawValue: "LAND"),
        content: "대 106㎡"
      ),
      AuctionDetail.SalesItemDetail(
        sequence: 2,
        type: AuctionDetail.SalesItemDetail.ItemDetailType(rawValue: "BUILDING"),
        content: "서울특별시 강동구 천호동 173-62 위지상\n벽돌조평슬래브지붕2층다가구주택(5가구)\n1층 56.85㎡ / 2층 54.19㎡ / 지층 60.11㎡"
      )
    ]
  }

  private static var nearbySalesStats: [AuctionDetail.NearbySalesStat] {
    [
      AuctionDetail.NearbySalesStat(
        term: 3,
        salesCount: 0,
        averageAppraisalPrice: 0,
        averageSalesPrice: 0,
        salesPriceRate: 0.0,
        averageFailBidCount: 0.0
      ),
      AuctionDetail.NearbySalesStat(
        term: 6,
        salesCount: 3,
        averageAppraisalPrice: 1_039_996_200,
        averageSalesPrice: 742_666_333,
        salesPriceRate: 0.73,
        averageFailBidCount: 2.0
      ),
      AuctionDetail.NearbySalesStat(
        term: 12,
        salesCount: 5,
        averageAppraisalPrice: 1_209_154_736,
        averageSalesPrice: 791_025_400,
        salesPriceRate: 0.71,
        averageFailBidCount: 2.0
      )
    ]
  }

  private static var rightsAnalysis: [AuctionDetail.RightsAnalysis] {
    [
      AuctionDetail.RightsAnalysis(
        name: "홍길동(mock)",
        role: "임차인",
        hasOppositionRight: "있음(mock)",
        moveInReportDate: "2024-01-15(mock)",
        occupationStatus: "점유중(mock)",
        priorityRepaymentRight: "있음(mock)",
        fixedDate: "2024-01-20(mock)",
        dividendRequest: "있음(mock)",
        dividendRequestDate: "2024-06-01(mock)",
        deposit: 50_000_000,
        monthlyRent: 500_000
      ),
      AuctionDetail.RightsAnalysis(
        name: "김철수(mock)",
        role: "채무자",
        hasOppositionRight: "없음(mock)",
        moveInReportDate: "2023-05-10(mock)",
        occupationStatus: "미점유(mock)",
        priorityRepaymentRight: "없음(mock)",
        fixedDate: "2023-05-15(mock)",
        dividendRequest: "없음(mock)",
        dividendRequestDate: "",
        deposit: 0,
        monthlyRent: 0
      )
    ]
  }

  // MARK: - Helpers

  private static func date(_ year: Int, _ month: Int, _ day: Int, _ hour: Int = 0, _ minute: Int = 0) -> Date {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.timeZone = TimeZone(identifier: "Asia/Seoul")
    return Calendar(identifier: .gregorian).date(from: components) ?? Date(timeIntervalSince1970: 0)
  }
}
