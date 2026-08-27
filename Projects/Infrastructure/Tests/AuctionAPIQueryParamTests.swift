import XCTest
@testable import Infrastructure
import Domain

final class AuctionAPIQueryParamTests: XCTestCase {
  func testAuctionSearchListIncludesRequestedPageSize() {
    let query = AuctionAPI.auctionSearchList(
      keyword: nil,
      region: nil,
      district: nil,
      buildTypes: ["APARTMENT"],
      auctionFailCount: nil,
      isCertified: nil,
      soldOutStatus: nil,
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
      soldOutStatus: nil,
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
      soldOutStatus: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: nil,
      sort: nil,
      size: nil
    ).queryParam

    XCTAssertEqual(query?["buildType"] as? [String], ["APARTMENT", "HOUSE", "VILLA"])
    XCTAssertEqual(query?["auctionFailCount"] as? [String], ["FIRST_AUCTION", "THIRD_AUCTION"])
  }

  func testAuctionSearchListMapsSoldOutStatus() {
    func soldOutStatus(_ filter: CurrentAuctionFilter) -> String? {
      AuctionAPI.auctionSearchList(
        keyword: nil,
        region: nil,
        district: nil,
        buildTypes: nil,
        auctionFailCount: nil,
        isCertified: nil,
        soldOutStatus: filter.soldOutStatus,
        minimumPrice: nil,
        maximumPrice: nil,
        nextCursor: nil,
        sort: nil,
        size: nil
      ).queryParam?["soldOutStatus"] as? String
    }

    var filter = CurrentAuctionFilter()
    XCTAssertEqual(soldOutStatus(filter), "ALL")

    filter.soldOutStatus = .notSoldOut
    XCTAssertEqual(soldOutStatus(filter), "NOT_SOLD_OUT")

    filter.soldOutStatus = .soldOut
    XCTAssertEqual(soldOutStatus(filter), "SOLD_OUT")
  }

  func testLogoutTargetsAuthenticatedLogoutEndpoint() {
    let api = AuthAPI.logout(deviceID: "device-id")

    XCTAssertEqual(api.domain, "v1/auth/")
    XCTAssertEqual(api.path, "logout")
    XCTAssertEqual(api.method, .post)
  }

  func testDecodesMissingKakaoEmailAsEmptyString() throws {
    let data = Data("""
    {
      "id": 1,
      "name": "카카오 사용자",
      "provider": "KAKAO",
      "status": "ACTIVE"
    }
    """.utf8)

    let user = try JSONDecoder().decode(SignInUserInfoDTO.self, from: data)

    XCTAssertEqual(user.email, "")
  }
}
