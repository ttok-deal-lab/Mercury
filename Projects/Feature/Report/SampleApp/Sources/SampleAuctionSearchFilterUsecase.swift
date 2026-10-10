import Foundation

import Domain

/// 샘플 앱용 지역 목록 스텁
struct SampleAuctionSearchFilterUsecase: AuctionSearchFilterUsecasable {
  func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter {
    let seoul = Region(code: "11", displayName: "서울특별시", districts: [
      District(code: "11000", displayName: "전체"),
      District(code: "11110", displayName: "종로구"),
      District(code: "11140", displayName: "중구"),
      District(code: "11650", displayName: "서초구")
    ])
    let busan = Region(code: "26", displayName: "부산광역시", districts: [
      District(code: "26000", displayName: "전체"),
      District(code: "26350", displayName: "해운대구")
    ])
    return AuctionSearchFilter(regions: [seoul, busan], buildingTypes: [], auctionFailOptions: [], verificationOptions: [], searchOptions: [])
  }
}
