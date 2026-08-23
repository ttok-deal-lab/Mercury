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
      isBidWon: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: 20
    ).queryParam

    XCTAssertEqual(query?["size"] as? Int, 20)
    XCTAssertEqual(query?["buildType"] as? [String], ["APARTMENT"])
    XCTAssertEqual(query?["auctionFailCount"] as? [String], ["ALL"])
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
      isBidWon: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: nil
    ).queryParam

    XCTAssertNil(query?["size"])
    XCTAssertEqual(query?["buildType"] as? [String], ["ALL"])
    XCTAssertEqual(query?["auctionFailCount"] as? [String], ["ALL"])
  }

  func testAuctionSearchListPassesMultipleBuildTypesSorted() {
    let query = AuctionAPI.auctionSearchList(
      keyword: nil,
      region: nil,
      district: nil,
      buildTypes: ["VILLA", "APARTMENT", "HOUSE"],
      auctionFailCount: ["THIRD_AUCTION", "FIRST_AUCTION"],
      isCertified: nil,
      isBidWon: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: nil
    ).queryParam

    XCTAssertEqual(query?["buildType"] as? [String], ["APARTMENT", "HOUSE", "VILLA"])
    XCTAssertEqual(query?["auctionFailCount"] as? [String], ["FIRST_AUCTION", "THIRD_AUCTION"])
  }

  func testAuctionSearchListMapsBidWonToSoldOutStatus() {
    func soldOutStatus(isBidWon: Bool?) -> String? {
      AuctionAPI.auctionSearchList(
        keyword: nil,
        region: nil,
        district: nil,
        buildTypes: nil,
        auctionFailCount: nil,
        isCertified: nil,
        isBidWon: isBidWon,
        minimumPrice: nil,
        maximumPrice: nil,
        nextCursor: nil,
        sort: nil,
        size: nil
      ).queryParam?["soldOutStatus"] as? String
    }

    XCTAssertEqual(soldOutStatus(isBidWon: true), "SOLD_OUT")
    XCTAssertEqual(soldOutStatus(isBidWon: false), "ALL")
    XCTAssertEqual(soldOutStatus(isBidWon: nil), "ALL")
  }
}
