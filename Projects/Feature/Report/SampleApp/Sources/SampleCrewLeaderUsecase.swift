import Foundation

import Domain

/// 샘플 앱용 스텁. 승인된 크루장으로 응답해 배너의 크루장 상태를 바로 볼 수 있게 한다.
struct SampleCrewLeaderUsecase: CrewLeaderUsecasable {
  func fetchMyCrewLeaderInfo() async throws -> CrewLeaderInfo? {
    CrewLeaderInfo(
      userId: 0,
      name: "샘플 크루장",
      introduction: nil,
      status: .active,
      statusReason: nil,
      averageRating: nil,
      reviewCount: nil,
      snsLinks: [],
      activityRegion: nil,
      certifications: nil,
      contact: nil,
      investmentAssets: nil,
      investmentYears: nil
    )
  }
}
