//
//  CrewLeaderRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import AppFoundation
import Networking
import Domain

public final class CrewLeaderRepository: CrewLeaderRepositoriable {
  private let signInInformation = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  public init() { }
  
  public func fetchMyCrewLeaderInfo() async throws -> CrewLeaderInfo? {
    guard let userID = signInInformation.userInfo?.id else {
      throw MercuryError(.notFoundUser)
    }
    do {
      let dto = try await CrewLeaderAPI.myCrewLeaderInfo(userID: userID)
        .request(CrewLeaderInfoDTO.self)
      return dto.toCrewLeaderInfo(fallbackUserId: userID)
    } catch let error as HTTPStatusError where error.statusCode == 404 {
      // 아직 크루장 신청을 하지 않은 사용자. 에러가 아니라 "정보 없음" 으로 돌려준다.
      return nil
    }
  }
}
