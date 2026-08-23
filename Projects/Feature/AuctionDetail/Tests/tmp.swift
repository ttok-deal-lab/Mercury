import XCTest
import CoreLocation

@testable import AuctionDetail
import AppFoundation
import Domain

@MainActor
final class AuctionDetailModelDataTests: XCTestCase {
  func test_sortedSalesDetailByTime_returnsNewestSaleFirst() async {
    let olderDate = Date(timeIntervalSince1970: 100)
    let middleDate = Date(timeIntervalSince1970: 200)
    let newestDate = Date(timeIntervalSince1970: 300)
    let auctionDetail = AuctionDetail.fixture(
      salesAddress: "서울특별시 강남구 테헤란로 123",
      salesDetails: [
        .init(timeStamp: olderDate, type: .sale, location: "A", leastSalesPrice: 100_000_000, result: .failedBid),
        .init(timeStamp: newestDate, type: .sale, location: "B", leastSalesPrice: 90_000_000, result: .sold),
        .init(timeStamp: middleDate, type: .sale, location: "C", leastSalesPrice: 95_000_000, result: .modified)
      ]
    )
    
    let modelData = AuctionDetailModelData(
      auctionID: auctionDetail.id,
      fetchAuctionDetail: { _ in auctionDetail },
      loadAuctionInterestState: { _ in false },
      addUserInterestAuction: { _ in },
      removeUserInterestAuction: { _ in },
      coordinateResolver: SpyAuctionDetailCoordinateResolver(result: nil)
    )
    
    await waitUntilLoaded(modelData)
    
    XCTAssertEqual(
      modelData.sortedSalesDetailByTime().map(\.timeStamp),
      [newestDate, middleDate, olderDate]
    )
  }

  func test_loadAuctionDetail_resolvesMapCoordinateUsingCandidateAddresses() async {
    let expectedCoordinate = CLLocationCoordinate2D(latitude: 37.1234, longitude: 127.5678)
    let resolver = SpyAuctionDetailCoordinateResolver(result: expectedCoordinate)
    let auctionDetail = AuctionDetail.fixture(
      salesAddress: "서울특별시 강남구 테헤란로 123",
      salesBuildings: [
        .init(
          address: .init(
            siDo: "서울특별시",
            gu: "강남구",
            dong: "역삼동",
            ri: "",
            full: "서울특별시 강남구 역삼동 100"
          ),
          detailAddress: "101동 202호",
          category: .generalResidential
        )
      ]
    )

    let modelData = AuctionDetailModelData(
      auctionID: auctionDetail.id,
      fetchAuctionDetail: { _ in auctionDetail },
      loadAuctionInterestState: { _ in false },
      addUserInterestAuction: { _ in },
      removeUserInterestAuction: { _ in },
      coordinateResolver: resolver
    )

    await waitUntilLoaded(modelData)

    XCTAssertEqual(modelData.auctionDetailItem?.id, auctionDetail.id)
    XCTAssertEqual(modelData.mapCoordinate?.latitude, expectedCoordinate.latitude)
    XCTAssertEqual(modelData.mapCoordinate?.longitude, expectedCoordinate.longitude)
    XCTAssertEqual(resolver.capturedCourtName, "서울중앙지방법원")
    XCTAssertEqual(
      resolver.capturedAddresses,
      [
        "서울특별시 강남구 테헤란로 123",
        "서울특별시 강남구 역삼동 100 101동 202호",
        "서울특별시 강남구 역삼동 100"
      ]
    )
  }

  func test_candidateMapAddresses_removesDuplicatesAndEmptyAddresses() {
    let auctionDetail = AuctionDetail.fixture(
      salesAddress: "서울특별시 강남구 테헤란로 123",
      salesBuildings: [
        .init(
          address: .init(
            siDo: "서울특별시",
            gu: "강남구",
            dong: "역삼동",
            ri: "",
            full: "서울특별시 강남구 테헤란로 123"
          ),
          detailAddress: "",
          category: .generalResidential
        )
      ]
    )

    XCTAssertEqual(
      AuctionDetailModelData.candidateMapAddresses(for: auctionDetail),
      ["서울특별시 강남구 테헤란로 123"]
    )
  }

  func test_loadAuctionDetail_loadsInitialInterestState_afterDetailFetch() async {
    let auctionDetail = AuctionDetail.fixture(salesAddress: "서울특별시 강남구 테헤란로 123")
    let modelData = AuctionDetailModelData(
      auctionID: auctionDetail.id,
      fetchAuctionDetail: { _ in auctionDetail },
      loadAuctionInterestState: { _ in true },
      addUserInterestAuction: { _ in },
      removeUserInterestAuction: { _ in },
      coordinateResolver: SpyAuctionDetailCoordinateResolver(result: nil)
    )
    
    await waitUntilLoaded(modelData)
    
    XCTAssertEqual(modelData.zzimCount, auctionDetail.zzimCount)
    XCTAssertTrue(modelData.isZzimed)
    XCTAssertNil(modelData.error)
  }

  func test_tapOnZzim_whenCurrentlyNotInterested_updatesInterestState_onSuccess() async {
    let auctionDetail = AuctionDetail.fixture(salesAddress: "서울특별시 강남구 테헤란로 123")
    var addCallCount = 0
    var removeCallCount = 0
    let modelData = AuctionDetailModelData(
      auctionID: auctionDetail.id,
      fetchAuctionDetail: { _ in auctionDetail },
      loadAuctionInterestState: { _ in false },
      addUserInterestAuction: { _ in addCallCount += 1 },
      removeUserInterestAuction: { _ in removeCallCount += 1 },
      coordinateResolver: SpyAuctionDetailCoordinateResolver(result: nil)
    )
    
    await waitUntilLoaded(modelData)
    await modelData.tapOnZzim()
    
    XCTAssertTrue(modelData.isZzimed)
    XCTAssertEqual(modelData.zzimCount, auctionDetail.zzimCount + 1)
    XCTAssertEqual(addCallCount, 1)
    XCTAssertEqual(removeCallCount, 0)
    XCTAssertNil(modelData.error)
  }

  func test_loadAuctionDetail_whenFetchFails_setsError_andSkipsCoordinateResolution() async {
    let resolver = SpyAuctionDetailCoordinateResolver(result: CLLocationCoordinate2D(latitude: 1, longitude: 1))
    let modelData = AuctionDetailModelData(
      auctionID: 1,
      fetchAuctionDetail: { _ in
        throw MercuryError(.unknown)
      },
      loadAuctionInterestState: { _ in false },
      addUserInterestAuction: { _ in },
      removeUserInterestAuction: { _ in },
      coordinateResolver: resolver
    )
    
    await waitUntilSettled(modelData)

    // 상세 로딩 실패는 alert(error) 이 아니라 재시도 뷰(loadError) 로 표현된다.
    XCTAssertNotNil(modelData.loadError)
    XCTAssertNil(modelData.auctionDetailItem)
    XCTAssertNil(modelData.mapCoordinate)
    XCTAssertFalse(modelData.isLoading)
    XCTAssertFalse(modelData.isLoadingMapCoordinate)
    XCTAssertEqual(resolver.resolveCallCount, 0)
  }

  func test_tapOnZzim_whenRequestFails_rollsBackState_andSetsError() async {
    let auctionDetail = AuctionDetail.fixture(salesAddress: "서울특별시 강남구 테헤란로 123")
    let modelData = AuctionDetailModelData(
      auctionID: auctionDetail.id,
      fetchAuctionDetail: { _ in auctionDetail },
      loadAuctionInterestState: { _ in false },
      addUserInterestAuction: { _ in
        throw MercuryError(.unknown)
      },
      removeUserInterestAuction: { _ in },
      coordinateResolver: SpyAuctionDetailCoordinateResolver(result: nil)
    )
    
    await waitUntilLoaded(modelData)
    await modelData.tapOnZzim()
    
    XCTAssertFalse(modelData.isZzimed)
    XCTAssertEqual(modelData.zzimCount, auctionDetail.zzimCount)
    XCTAssertNotNil(modelData.error)
    XCTAssertFalse(modelData.isLoadingZzim)
  }

  private func waitUntilLoaded(_ modelData: AuctionDetailModelData) async {
    for _ in 0..<20 {
      if modelData.auctionDetailItem != nil, !modelData.isLoadingMapCoordinate, !modelData.isLoadingZzim {
        return
      }

      try? await Task.sleep(nanoseconds: 50_000_000)
    }

    XCTFail("Auction detail model data did not finish loading in time.")
  }
  
  private func waitUntilSettled(_ modelData: AuctionDetailModelData) async {
    var hasObservedStateChange = false
    
    for _ in 0..<20 {
      if modelData.isLoading || modelData.isLoadingMapCoordinate || modelData.auctionDetailItem != nil || modelData.error != nil || modelData.loadError != nil {
        hasObservedStateChange = true
      }
      
      if hasObservedStateChange, !modelData.isLoading, !modelData.isLoadingMapCoordinate {
        return
      }
      
      try? await Task.sleep(nanoseconds: 50_000_000)
    }
    
    XCTFail("Auction detail model data did not settle in time.")
  }
}

private final class SpyAuctionDetailCoordinateResolver: AuctionDetailCoordinateResolving {
  private(set) var capturedCourtName: String?
  private(set) var capturedAddresses: [String] = []
  private(set) var resolveCallCount: Int = 0
  private let result: CLLocationCoordinate2D?

  init(result: CLLocationCoordinate2D?) {
    self.result = result
  }

  func resolveCoordinate(courtName: String, addresses: [String]) async -> CLLocationCoordinate2D? {
    self.resolveCallCount += 1
    self.capturedCourtName = courtName
    self.capturedAddresses = addresses
    return result
  }
}

private extension AuctionDetail {
  static func fixture(
    id: Int = 1,
    salesAddress: String,
    salesDetails: [AuctionDetail.SalesDetail] = [],
    salesBuildings: [AuctionDetail.SalesBuilding] = []
  ) -> AuctionDetail {
    .init(
      id: id,
      salesNumber: "2026타경12345",
      itemTypes: [.apartment],
      appraisalPrice: 500_000_000,
      lowestSalesPrice: 400_000_000,
      bidType: .scheduledBid,
      salesDateTime: Date(timeIntervalSince1970: 0),
      salesLocation: "서울중앙지방법원",
      salesNote: "",
      salesReceptionDate: Date(timeIntervalSince1970: 0),
      salesOpenDate: Date(timeIntervalSince1970: 0),
      distributionRequiredDeadlineDate: Date(timeIntervalSince1970: 0),
      salesAddress: salesAddress,
      salesCategories: [.apartment],
      failBidCount: 0,
      zzimCount: 0,
      court: .init(code: .seoulCentralDistrict, team: "1계"),
      // ModelData 는 지오코딩 폴백 시 courtInfo.address 를 resolver 의 courtName 인자로 넘긴다.
      courtInfo: .init(
        code: "B000210",
        name: "SEOUL_CENTRAL_DISTRICT",
        address: "서울중앙지방법원"
      ),
      salesDetails: salesDetails,
      salesPictures: [],
      salesBuildings: salesBuildings,
      salesItemDetails: [],
      conditionReport: .init(
        investigationDate: Date(timeIntervalSince1970: 0),
        estateLeaseInfos: [],
        occupationRelations: [],
        occupationRelationReports: []
      ),
      appraisalDocumentUrl: nil,
      appraisalDocuments: [],
      nearbySalesStats: [],
      soldOut: false,
      verified: false,
      salesBuildingName: "테헤란로아파트",
      exclusiveArea: 84.97,
      caseName: "임의경매",
      creditorCount: 1,
      recentTransactionPrice: nil,
      recentTransactionDate: nil,
      rightsAnalysis: []
    )
  }
}
