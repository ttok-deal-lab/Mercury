import Foundation

import Domain

/// 샘플 앱용 주소 검색 스텁 (카카오 키 없이 화면 흐름 확인)
struct SampleAddressSearchUsecase: AddressSearchUsecasable {
  private static let sample = AddressInfo(
    zipCode: "03785",
    roadAddress: "서울특별시 서초구 사평대로 310-4",
    jibunAddress: "서울특별시 서초구 반포동 30-15",
    buildingName: "센트레빌 아스테리움",
    province: "서울",
    city: "서초구",
    district: "반포동",
    latitude: 37.5048,
    longitude: 127.0047
  )
  
  func searchAddress(query: String) async throws -> [AddressInfo] {
    [Self.sample]
  }
  
  func address(latitude: Double, longitude: Double) async throws -> AddressInfo? {
    AddressInfo(
      zipCode: nil,
      roadAddress: "서울특별시 서대문구 연희로 2길 76",
      jibunAddress: "서울특별시 서대문구 창천동 376",
      buildingName: nil,
      province: "서울",
      city: "서대문구",
      district: "창천동",
      latitude: latitude,
      longitude: longitude
    )
  }
}
