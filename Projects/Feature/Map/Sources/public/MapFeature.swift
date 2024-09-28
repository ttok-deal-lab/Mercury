//
//  MapFeature.swift
//  Map
//
//  Created by 송하민 on 8/10/24.
//

import Foundation
import CoreLocation
import AppFoundation
import Service
import ComposableArchitecture

@Reducer
public struct MapFeature {
  
  @ObservableState
  public struct State: Equatable {
    public var error: MercuryError?
    public var isMapDraw: Bool
    public var isShowDeniedLocationAlert: Bool
    public var userLocation: CLLocationCoordinate2D?
    public var cameraCenterLocation: CLLocationCoordinate2D?
    
    public init(
      error: MercuryError? = nil,
      isMapDraw: Bool = true,
      isShowDeniedLocationAlert: Bool = false,
      userLocation: CLLocationCoordinate2D? = nil,
      cameraCenterLocation: CLLocationCoordinate2D? = nil
    ) {
      self.error = error
      self.isMapDraw = isMapDraw
      self.isShowDeniedLocationAlert = isShowDeniedLocationAlert
      self.userLocation = userLocation
      self.cameraCenterLocation = cameraCenterLocation
    }
  }
  
  public enum Action: BindableAction, Equatable {
    case binding(BindingAction<State>)
    case setError(MercuryError)
    case setDrawMap(Bool)
    case checkUserAuthorization
    case requestLocationAuthentication
    case setIsShowDeniedLocationAlert(Bool)
    case updateUserLocation
    case setUserLocation(CLLocationCoordinate2D)
    case setCameraCenterLocation(CLLocationCoordinate2D?)
  }
  
  // MARK: - private property
  
  @Dependency(\.userLocationClient) private var userLocationClient
  
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .setError(let error):
        state.error = error
        return .none
      case .setDrawMap(let isDraw):
        state.isMapDraw = isDraw
        return .none
      case .checkUserAuthorization:
        return .run { send in
          if let status = self.userLocationClient.userAuthorization() {
            switch status {
            case .notDetermined, .restricted:
              await send(.requestLocationAuthentication)
            case .denied:
              await send(.setIsShowDeniedLocationAlert(true))
            case .authorizedAlways, .authorizedWhenInUse:
              await send(.updateUserLocation)
            @unknown default:
              await send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
            }
          }
        }
      case .requestLocationAuthentication:
        return .run { send in
          if let status = await self.userLocationClient.requestUserAuthorization() {
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
              await send(.updateUserLocation)
            case .denied:
              await send(.setIsShowDeniedLocationAlert(true))
            default:
              break
            }
          }
        }
      case .setIsShowDeniedLocationAlert(let isShow):
        state.isShowDeniedLocationAlert = isShow
        return .none
      case .updateUserLocation:
        return .run { send in
          if let location = self.userLocationClient.userCurrentLocation() {
            await send(.setUserLocation(location))
          } else {
            await send(.setError(.init(from: .ownModule(.map), .failToGetUserLocationCoordinate)))
          }
        }
      case .setUserLocation(let location):
        state.userLocation = location
        return .none
      case .setCameraCenterLocation(let location):
        state.cameraCenterLocation = location
        return .none
      }
    }
  }
}

