import XCTest

@testable import Infrastructure

final class AuctionDetailDTODateParsingTests: XCTestCase {

  // MARK: - Helpers

  private func makeSalesDetailDTO(timeStamp: String, type: String = "SALE_DECISION") -> SalesDetailDTO {
    return SalesDetailDTO(
      timeStamp: timeStamp,
      type: type,
      location: "고양지원 제101호 입찰법정",
      leastSalesPrice: 267_000_000,
      result: "PLANNED"
    )
  }

  private func koreanDate(
    year: Int,
    month: Int,
    day: Int,
    hour: Int = 0,
    minute: Int = 0,
    second: Int = 0
  ) -> Date? {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
    return calendar.date(
      from: DateComponents(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second
      )
    )
  }

  // MARK: - Tests

  /// 서버가 실제로 내려주는 포맷. ISO8601 파서만 쓰면 nil 이 되어 1970-01-01 로 표기되던 회귀 케이스.
  func testParsesSpaceSeparatedServerTimeStamp() {
    let entity = makeSalesDetailDTO(timeStamp: "2026-09-01 14:00:00").toEntity()

    XCTAssertEqual(entity.timeStamp, koreanDate(year: 2026, month: 9, day: 1, hour: 14))
  }

  func testParsesISO8601TimeStamp() {
    let entity = makeSalesDetailDTO(timeStamp: "2026-09-01T14:00:00+09:00").toEntity()

    XCTAssertEqual(entity.timeStamp, koreanDate(year: 2026, month: 9, day: 1, hour: 14))
  }

  func testParsesISO8601TimeStampWithoutOffset() {
    let entity = makeSalesDetailDTO(timeStamp: "2026-09-01T14:00:00").toEntity()

    XCTAssertEqual(entity.timeStamp, koreanDate(year: 2026, month: 9, day: 1, hour: 14))
  }

  func testParsesDateOnlyTimeStamp() {
    let entity = makeSalesDetailDTO(timeStamp: "2026-09-01").toEntity()

    XCTAssertEqual(entity.timeStamp, koreanDate(year: 2026, month: 9, day: 1))
  }

  /// 파싱 실패는 nil 로 남아야 한다. 1970-01-01 같은 가짜 날짜로 대체하면 안 된다.
  func testKeepsNilForUnparsableTimeStamp() {
    XCTAssertNil(makeSalesDetailDTO(timeStamp: "2026-99-99 99:99:99").toEntity().timeStamp)
    XCTAssertNil(makeSalesDetailDTO(timeStamp: "").toEntity().timeStamp)
  }

  /// 서버는 기일 종류를 한글이 아닌 `SALE` / `SALE_DECISION` 코드로 내려준다.
  func testMapsServerSalesDetailTypeCodes() {
    let sale = makeSalesDetailDTO(timeStamp: "2026-09-01 10:00:00", type: "SALE").toEntity()
    let saleDecision = makeSalesDetailDTO(timeStamp: "2026-09-01 14:00:00", type: "SALE_DECISION").toEntity()

    XCTAssertEqual(sale.type.displayName, "매각기일")
    XCTAssertEqual(saleDecision.type.displayName, "매각결정기일")
  }

  /// 미매핑 코드는 원본 문자열을 유지한다.
  func testKeepsRawValueForUnknownSalesDetailType() {
    let entity = makeSalesDetailDTO(timeStamp: "2026-09-01 10:00:00", type: "NEW_CODE").toEntity()

    XCTAssertEqual(entity.type.displayName, "NEW_CODE")
  }
}
