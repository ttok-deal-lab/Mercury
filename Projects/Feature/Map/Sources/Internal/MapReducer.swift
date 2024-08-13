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
import ComposableArchitecture

@Reducer
public struct MapReducer {
  
  @ObservableState
  public struct State: Equatable {
    public static func == (lhs: MapReducer.State, rhs: MapReducer.State) -> Bool {
      return lhs.userLocation?.latitude == rhs.userLocation?.latitude &&
      lhs.userLocation?.longitude == rhs.userLocation?.longitude
    }
    public var error: MercuryError?
    public var userLocation: CLLocationCoordinate2D?
    public var isShowDeniedLocationAlert: Bool = false
    public var isMapDraw: Bool = true
    
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
    case showDeniedLocationAlert
    case setUserLocation(CLLocationCoordinate2D)
    
  }
  
  // MARK: - private property
  
  @Dependency(\.userLocationUsecase) private var userLocationUsecase
  
  
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
          let status = await self.userLocationUsecase.userAuthorization()
          await send(.setAuthenticationStatus(status))
        }
      case .setAuthenticationStatus(let status):
        switch status {
        case .notDetermined, .restricted:
          return .send(.requestLocationAuthentication)
        case .denied:
          return .send(.showDeniedLocationAlert)
        case .authorizedAlways, .authorizedWhenInUse:
          return .run { send in
            await updateUserLocation(send: send)
          }
        @unknown default:
          return .send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
        }
      case .requestLocationAuthentication:
        return .run { @MainActor send in
          let status = await self.userLocationUsecase.requestUserAuthorization()
          send(.locationAuthorizationChanged(status))
        }
      case .locationAuthorizationChanged(let status):
        return .run { send in
          switch status {
          case .authorizedAlways, .authorizedWhenInUse:
            await updateUserLocation(send: send)
          default:
            break
          }
        }
      case .showDeniedLocationAlert:
        state.isShowDeniedLocationAlert = true
        return .none
      case .setUserLocation(let location):
        state.userLocation = location
        return .none
      }
    }
  }
  
  private func updateUserLocation(send: Send<Action>) async {
    let userLocation = await userLocationUsecase.userCurrentLocation()
    guard let userLocationCoordinate = userLocation?.coordinate else {
      return await send(.setError(.init(from: .ownModule(.map), .failToGetUserLocationCoordinate)))
    }
    await send(.setUserLocation(userLocationCoordinate))
  }
  
}

