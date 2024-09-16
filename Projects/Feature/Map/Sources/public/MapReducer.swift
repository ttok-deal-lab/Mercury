//
//  MapReducer.swift
//  Map
//
//  Created by 송하민 on 8/10/24.
//

import Combine
import Foundation
import CoreLocation
import AppFoundation
import Domain
import ComposableArchitecture

@Reducer
public struct MapReducer {
  
  @ObservableState
  public struct State: Equatable {
    public static func == (lhs: MapReducer.State, rhs: MapReducer.State) -> Bool {
      guard let lhsLocation = lhs.userLocation, let rhsLocation = rhs.userLocation else {
        return false
      }
      return lhsLocation.latitude == rhsLocation.latitude && lhsLocation.longitude == rhsLocation.longitude
    }
    public var error: MercuryError?
    public var isMapDraw: Bool = true
    public var isShowDeniedLocationAlert: Bool = false
    public var userLocation: CLLocationCoordinate2D?
    public var cameraCenterLocation: CLLocationCoordinate2D?
    public var auctionItems: [AuctionItem]?
    public init() { }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case setError(MercuryError)
    case setDrawMap(Bool)
    case checkUserAuthorization
    case setAuthenticationStatus(CLAuthorizationStatus)
    case locationAuthorizationChanged(CLAuthorizationStatus)
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
          let status = self.userLocationClient.userAuthorization()
          await send(.setAuthenticationStatus(status))
        }
      case .setAuthenticationStatus(let status):
        switch status {
        case .notDetermined, .restricted:
          return .send(.requestLocationAuthentication)
        case .denied:
          return .send(.setIsShowDeniedLocationAlert(true))
        case .authorizedAlways, .authorizedWhenInUse:
          return .run { send in
            await send(.updateUserLocation)
          }
        @unknown default:
          return .send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
        }
      case .requestLocationAuthentication:
        return .run { @MainActor send in
          for await status in self.userLocationClient.requestUserAuthorization() {
            send(.locationAuthorizationChanged(status))
          }
        }
      case .locationAuthorizationChanged(let status):
        return .run { send in
          switch status {
          case .authorizedAlways, .authorizedWhenInUse:
            await send(.updateUserLocation)
          case .denied:
            await send(.setIsShowDeniedLocationAlert(true))
          default:
            break
          }
        }
      case .setIsShowDeniedLocationAlert(let isShow):
        state.isShowDeniedLocationAlert = isShow
        return .none
      case .updateUserLocation:
        return .run { send in
          if let location = self.userLocationClient.userCurrentLocation()?.coordinate {
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

