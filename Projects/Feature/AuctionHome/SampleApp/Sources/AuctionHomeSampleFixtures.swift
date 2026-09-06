import Foundation

import AppFoundation
import Domain

actor SampleAuctionSalesListUsecase: AuctionSalesListUsecasable {
  private let pageSize = 20
  private var nextStartIndexByFilterKey: [String: Int] = [:]
  private let allItems: [AuctionSalesItem] = SampleAuctionDataFactory.makeItems()

  func fetchAuctionSales(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
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

struct SampleAuctionSearchFilterUsecase: AuctionSearchFilterUsecasable {
  func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter {
    AuctionSearchFilter(
      regions: [
        Region(code: "ALL", displayName: "전체", districts: [])
      ],
      buildingTypes: [
        Option(code: AuctionSalesCategory.apartment.rawValue, displayName: "아파트"),
        Option(code: AuctionSalesCategory.villa.rawValue, displayName: "빌라"),
        Option(code: AuctionSalesCategory.office_tel.rawValue, displayName: "오피스텔")
      ],
      auctionFailOptions: [
        Option(code: "ALL", displayName: "전체")
      ],
      verificationOptions: [
        Option(code: "ALL", displayName: "전체")
      ],
      searchOptions: [
        Option(code: "LATEST_REGISTERED", displayName: "최신순")
      ]
    )
  }
}

actor SampleAuctionInterestUsecase: AuctionInterestUsecasable {
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

enum SampleAuctionDataFactory {
  static func makeItems() -> [AuctionSalesItem] {
    let apartments = (1...24).map { index in
      makeItem(
        id: index,
        address: "서울특별시 강남구 샘플로 \(index)",
        buildingName: "아파트 \(index)호",
        category: .apartment,
        price: 500_000_000 + index * 1_000_000,
        isSoldOut: index % 4 == 0
      )
    }

    let villas = (1...8).map { index in
      makeItem(
        id: 100 + index,
        address: "서울특별시 마포구 빌라길 \(index)",
        buildingName: "빌라 \(index)호",
        category: .villa,
        price: 300_000_000 + index * 500_000,
        isSoldOut: index % 4 == 0
      )
    }

    let officetels = (1...6).map { index in
      makeItem(
        id: 200 + index,
        address: "서울특별시 서초구 오피스텔로 \(index)",
        buildingName: "오피스텔 \(index)호",
        category: .office_tel,
        price: 400_000_000 + index * 750_000,
        isSoldOut: index % 4 == 0
      )
    }

    return apartments + villas + officetels
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
      verified: id % 2 == 0,
      isSoldOut: isSoldOut
    )
  }
}
