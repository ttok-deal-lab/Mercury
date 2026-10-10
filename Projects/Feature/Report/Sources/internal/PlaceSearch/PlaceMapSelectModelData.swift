//
//  PlaceMapSelectModelData.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import AppFoundation
import Domain
import Router

@Observable
final class PlaceMapSelectModelData {
  // MARK: - internal property
  /// 지도 중앙의 주소. 바다 등 주소가 없는 곳이면 nil.
  var centerAddress: AddressInfo?
  var isResolving: Bool = false
  var isMoving: Bool = false
  var moveRequest: LocationPickerMoveRequest?
  var error: Error?
  
  let initialLatitude: Double
  let initialLongitude: Double
  
  // MARK: - private property
  private let addressSearchUsecase: AddressSearchUsecasable
  private var resolveTask: Task<Void, Never>?
  /// 서울시청. 이전에 고른 장소가 없을 때 처음 보여줄 위치.
  private static let defaultCoordinate = (latitude: 37.5666, longitude: 126.9784)
  
  // MARK: - life cycle
  init(addressSearchUsecase: AddressSearchUsecasable, initialPlace: AddressInfo?) {
    self.addressSearchUsecase = addressSearchUsecase
    self.initialLatitude = initialPlace?.latitude ?? Self.defaultCoordinate.latitude
    self.initialLongitude = initialPlace?.longitude ?? Self.defaultCoordinate.longitude
    self.centerAddress = initialPlace
  }
  
  // MARK: - internal method
  
  /// 지도가 멈출 때마다 호출. 빠르게 여러 번 멈추면 마지막 좌표만 조회한다.
  func centerChanged(latitude: Double, longitude: Double) {
    isMoving = false
    resolveTask?.cancel()
    resolveTask = Task { @MainActor in
      isResolving = true
      defer { isResolving = false }
      do {
        let address = try await addressSearchUsecase.address(latitude: latitude, longitude: longitude)
        guard !Task.isCancelled else { return }
        centerAddress = address
      } catch {
        guard !Task.isCancelled else { return }
        self.error = error.toMercuryError() ?? MercuryError(.unknown)
      }
    }
  }
  
  func moveStarted() {
    isMoving = true
  }
  
  func moveTo(latitude: Double, longitude: Double) {
    moveRequest = LocationPickerMoveRequest(latitude: latitude, longitude: longitude)
  }
}
