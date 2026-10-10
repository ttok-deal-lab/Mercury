//
//  LocationPickerMoveRequest.swift
//  Router
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 위치 선택 지도에 "이 좌표로 카메라를 옮겨라" 를 전달하는 요청.
/// 같은 좌표를 다시 요청해도 반영되도록 id 로 구분한다.
public struct LocationPickerMoveRequest: Equatable {
  public let id: UUID
  public let latitude: Double
  public let longitude: Double
  
  public init(latitude: Double, longitude: Double) {
    self.id = UUID()
    self.latitude = latitude
    self.longitude = longitude
  }
}
