import XCTest
@testable import Infrastructure

final class AuctionAPIQueryParamTests: XCTestCase {
  func testAuctionSearchListIncludesRequestedPageSize() {
    let query = AuctionAPI.auctionSearchList(
      keyword: nil,
      region: nil,
      district: nil,
      buildTypes: ["APARTMENT"],
      auctionFailCount: nil,
      isCertified: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: 20
    ).queryParam

    XCTAssertEqual(query?["size"] as? Int, 20)
    XCTAssertEqual(query?["buildType"] as? String, "APARTMENT")
    XCTAssertEqual(query?["region"] as? String, "ALL")
  }

  func testAuctionSearchListDefaultsSizeToNilWhenNotProvided() {
    let query = AuctionAPI.auctionSearchList(
      keyword: nil,
      region: nil,
      district: nil,
      buildTypes: nil,
      auctionFailCount: nil,
      isCertified: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: nil
    ).queryParam

    XCTAssertNil(query?["size"])
    XCTAssertEqual(query?["buildType"] as? String, "ALL")
  }
}
