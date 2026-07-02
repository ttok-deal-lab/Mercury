import XCTest
@testable import Infrastructure

final class AuctionSalesDTOTests: XCTestCase {
  func testToEntityTreatsUnknownCursorAsNil() {
    let dto = AuctionSalesDTO(
      searchHitCount: 8,
      auctionItemResponses: [],
      nextCursor: "unknown"
    )

    let entity = dto.toEntity()

    XCTAssertNil(entity.nextCursor)
  }

  func testToEntityPreservesRealCursor() {
    let dto = AuctionSalesDTO(
      searchHitCount: 8,
      auctionItemResponses: [],
      nextCursor: "CURSOR_123"
    )

    let entity = dto.toEntity()

    XCTAssertEqual(entity.nextCursor, "CURSOR_123")
  }
}
