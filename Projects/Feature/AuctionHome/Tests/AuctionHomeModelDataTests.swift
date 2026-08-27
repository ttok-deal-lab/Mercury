import XCTest
@testable import AuctionHome
import AppFoundation
import Domain

@MainActor
final class AuctionHomeModelDataTests: XCTestCase {
  func testApartmentFilterLoadsExpectedCountAndPaging() async throws {
    let modelData = AuctionHomeModelData(
      localStorageUsecase: NoopLocalStorageUsecase(),
      auctionListUsecase: StubAuctionSalesListUsecase(),
      auctionSearchFilterUsecase: StubAuctionSearchFilterUsecase(),
      auctionInterestUsecase: StubAuctionInterestUsecase()
    )

    try await modelData.fetchSearchFilters()
    modelData.currentAuctionFilter.buildingTypeCodes = [AuctionSalesCategory.apartment.rawValue]

    await modelData.loadAuctionSalesList()

    XCTAssertEqual(modelData.filteredItemCount, 24)
    XCTAssertEqual(modelData.auctionSalesItems.count, 20)
    XCTAssertTrue(
      modelData.auctionSalesItems.allSatisfy { item in
        item.salesCategories.contains(.apartment)
      }
    )

    await modelData.loadMoreAuctionSales()

    XCTAssertEqual(modelData.auctionSalesItems.count, 24)
    XCTAssertTrue(
      modelData.auctionSalesItems.allSatisfy { item in
        item.salesCategories.contains(.apartment)
      }
    )
  }

  func testBidWonFilterLoadsOnlySoldOutItems() async throws {
    let listUsecase = StubAuctionSalesListUsecase()
    let modelData = AuctionHomeModelData(
      localStorageUsecase: NoopLocalStorageUsecase(),
      auctionListUsecase: listUsecase,
      auctionSearchFilterUsecase: StubAuctionSearchFilterUsecase(),
      auctionInterestUsecase: StubAuctionInterestUsecase()
    )

    try await modelData.fetchSearchFilters()
    modelData.currentAuctionFilter.soldOutStatus = .soldOut

    await modelData.loadAuctionSalesList()

    // 낙찰 여부가 실제로 하위 계층까지 전달되어야 한다.
    let receivedFilter = await listUsecase.receivedFilter()
    XCTAssertEqual(receivedFilter?.soldOutStatus, .soldOut)

    // 매각 완료 매물만 남는다. (아파트 6건 + 빌라 2건)
    XCTAssertEqual(modelData.filteredItemCount, 8)
    XCTAssertEqual(modelData.auctionSalesItems.count, 8)
    XCTAssertTrue(modelData.auctionSalesItems.allSatisfy { $0.isSoldOut })
    XCTAssertTrue(modelData.isFilterActive(.bidWon))
  }

  func testNotSoldOutFilterExcludesSoldOutItems() async throws {
    let modelData = AuctionHomeModelData(
      localStorageUsecase: NoopLocalStorageUsecase(),
      auctionListUsecase: StubAuctionSalesListUsecase(),
      auctionSearchFilterUsecase: StubAuctionSearchFilterUsecase(),
      auctionInterestUsecase: StubAuctionInterestUsecase()
    )

    try await modelData.fetchSearchFilters()
    modelData.currentAuctionFilter.soldOutStatus = .notSoldOut

    await modelData.loadAuctionSalesList()

    XCTAssertEqual(modelData.filteredItemCount, 24)
    XCTAssertTrue(modelData.auctionSalesItems.allSatisfy { !$0.isSoldOut })
    XCTAssertTrue(modelData.isFilterActive(.bidWon))
  }

  func testInitialLoadFailureSetsLoadError() async throws {
    let modelData = AuctionHomeModelData(
      localStorageUsecase: NoopLocalStorageUsecase(),
      auctionListUsecase: FailingAuctionSalesListUsecase(),
      auctionSearchFilterUsecase: StubAuctionSearchFilterUsecase(),
      auctionInterestUsecase: StubAuctionInterestUsecase()
    )

    await modelData.loadAuctionSalesList()

    XCTAssertNotNil(modelData.loadError)
    XCTAssertTrue(modelData.auctionSalesItems.isEmpty)
  }

  func testTurningOffBidWonFilterRestoresFullList() async throws {
    let modelData = AuctionHomeModelData(
      localStorageUsecase: NoopLocalStorageUsecase(),
      auctionListUsecase: StubAuctionSalesListUsecase(),
      auctionSearchFilterUsecase: StubAuctionSearchFilterUsecase(),
      auctionInterestUsecase: StubAuctionInterestUsecase()
    )

    try await modelData.fetchSearchFilters()
    modelData.currentAuctionFilter.soldOutStatus = .soldOut
    await modelData.loadAuctionSalesList()
    XCTAssertEqual(modelData.filteredItemCount, 8)

    modelData.currentAuctionFilter.soldOutStatus = .all
    await modelData.loadAuctionSalesList()

    XCTAssertEqual(modelData.filteredItemCount, 32)
    XCTAssertFalse(modelData.auctionSalesItems.allSatisfy { $0.isSoldOut })
    XCTAssertFalse(modelData.isFilterActive(.bidWon))
  }
}

private actor StubAuctionSalesListUsecase: AuctionSalesListUsecasable {
  private let pageSize = 20
  private var nextStartIndexByFilterKey: [String: Int] = [:]
  private let allItems = StubAuctionDataFactory.makeItems()
  private var lastFilter: CurrentAuctionFilter?

  /// ModelData 가 실제로 어떤 필터를 넘겼는지 확인용
  func receivedFilter() -> CurrentAuctionFilter? { lastFilter }

  func fetchAuctionSales(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    lastFilter = filter
    let filteredItems = filteredItems(for: filter)
    let firstPage = Array(filteredItems.prefix(pageSize))
    nextStartIndexByFilterKey[filterKey(for: filter)] = firstPage.count
    return (auctionCount: filteredItems.count, items: firstPage)
  }

  func fetchNextAuctionSales(filter: CurrentAuctionFilter?) async throws -> [AuctionSalesItem] {
    let filteredItems = filteredItems(for: filter)
    let key = filterKey(for: filter)
    let startIndex = nextStartIndexByFilterKey[key, default: pageSize]
    guard startIndex < filteredItems.count else { return [] }

    let nextIndex = min(startIndex + pageSize, filteredItems.count)
    nextStartIndexByFilterKey[key] = nextIndex
    return Array(filteredItems[startIndex..<nextIndex])
  }

  private func filteredItems(for filter: CurrentAuctionFilter?) -> [AuctionSalesItem] {
    var items = allItems

    if let selectedTypes = filter?.buildingTypeCodes, !selectedTypes.isEmpty {
      items = items.filter { item in
        !selectedTypes.isDisjoint(with: Set(item.salesCategories.map(\.rawValue)))
      }
    }

    switch filter?.soldOutStatus {
    case .soldOut:
      items = items.filter(\.isSoldOut)
    case .notSoldOut:
      items = items.filter { !$0.isSoldOut }
    case .all, .none:
      break
    }

    return items
  }

  private func filterKey(for filter: CurrentAuctionFilter?) -> String {
    let buildingTypes = filter?.buildingTypeCodes?.sorted().joined(separator: ",") ?? "ALL"
    return [
      filter?.region?.code ?? "ALL",
      filter?.district?.code ?? "unknown",
      buildingTypes,
      filter?.soldOutStatus.rawValue ?? "ALL",
      filter?.sort?.code ?? "LATEST_REGISTERED"
    ].joined(separator: "|")
  }
}

private actor FailingAuctionSalesListUsecase: AuctionSalesListUsecasable {
  func fetchAuctionSales(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    throw MercuryError(.failToConnectInternet)
  }

  func fetchNextAuctionSales(filter: CurrentAuctionFilter?) async throws -> [AuctionSalesItem] {
    throw MercuryError(.failToConnectInternet)
  }
}

private struct StubAuctionSearchFilterUsecase: AuctionSearchFilterUsecasable {
  func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter {
    AuctionSearchFilter(
      regions: [Region(code: "ALL", displayName: "전체", districts: [])],
      buildingTypes: [
        Option(code: AuctionSalesCategory.apartment.rawValue, displayName: "아파트"),
        Option(code: AuctionSalesCategory.villa.rawValue, displayName: "빌라")
      ],
      auctionFailOptions: [Option(code: "ALL", displayName: "전체")],
      verificationOptions: [Option(code: "ALL", displayName: "전체")],
      searchOptions: [Option(code: "LATEST_REGISTERED", displayName: "최신순")]
    )
  }
}

private actor StubAuctionInterestUsecase: AuctionInterestUsecasable {
  func isAuctionInterested(auctionID: Int) async throws -> Bool { false }
  func addInterest(auctionID: Int) async throws { }
  func removeInterest(auctionID: Int) async throws { }
  func resetPagination() async { }
  func loadInterest() async throws -> [InterestItem] { [] }
  func loadNextInterest() async throws -> [InterestItem] { [] }
  func loadInterestList(ids: [Int]) async throws -> [InterestWhether] {
    ids.map { InterestWhether(id: $0, favorite: false) }
  }
}

private final class NoopLocalStorageUsecase: LocalStorageUsecasable {
  func isKeyExist(forKey key: String) async -> Bool { false }
  func setModel<T: Codable>(_ value: T, forKey key: String) async { }
  func getModel<T: Codable>(forKey key: String, as type: T.Type) async -> T? { nil }
  func set<T>(_ value: T, forKey key: String) async where T: Any { }
  func get<T>(forKey key: String) async -> T? { nil }
  func remove(forKey key: String) async { }
}

private enum StubAuctionDataFactory {
  static func makeItems() -> [AuctionSalesItem] {
    let apartments = (1...24).map { index in
      makeItem(
        id: index,
        address: "서울특별시 강남구 샘플로 \(index)",
        buildingName: "아파트 \(index)호",
        category: .apartment,
        price: 500_000_000 + index * 1_000_000,
        isSoldOut: index.isMultiple(of: 4)
      )
    }

    let villas = (1...8).map { index in
      makeItem(
        id: 100 + index,
        address: "서울특별시 마포구 빌라길 \(index)",
        buildingName: "빌라 \(index)호",
        category: .villa,
        price: 300_000_000 + index * 500_000,
        isSoldOut: index.isMultiple(of: 4)
      )
    }

    return apartments + villas
  }

  private static func makeItem(
    id: Int,
    address: String,
    buildingName: String,
    category: AuctionSalesCategory,
    price: Int,
    isSoldOut: Bool
  ) -> AuctionSalesItem {
    AuctionSalesItem(
      id: id,
      caseNumber: "2026타경\(1000 + id)",
      salesAddress: address,
      salesCategories: [category],
      salesBuildingName: buildingName,
      salesDateTime: Date().addingTimeInterval(86400 * 3),
      appraisalPrice: String(price),
      salesPictures: nil,
      failBidCount: id % 3,
      zzimCount: id % 5,
      registerDate: Date().addingTimeInterval(-86400 * 2),
      verified: id.isMultiple(of: 2),
      isSoldOut: isSoldOut
    )
  }
}
