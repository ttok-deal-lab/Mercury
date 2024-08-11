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
    public var isShowAlert: Bool = false
    public var isMapDraw: Bool = true
    
    
    public init() {
      
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case setDrawMap(Bool)
    case checkUserAuthorization
    case setAuthenticationStatus(CLAuthorizationStatus)
    case locationAuthorizationChanged(CLAuthorizationStatus)
    case setError(MercuryError)
    case requestLocationAuthentication
    case showAlert
    case setUserLocation(CLLocationCoordinate2D)
    case locationUpdated(CLLocation)
    
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
          return .send(.showAlert)
        case .authorizedAlways, .authorizedWhenInUse:
          let userLocation = self.userLocationUsecase.userCurrentLocation()
          guard let coordinate = userLocation?.coordinate else {
            return .send(.setError(.init(from: .ownModule(.map), .failToGetUserLocationCoordinate)))
          }
          return .send(.setUserLocation(coordinate))
        @unknown default:
          return .send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
        }
      case .requestLocationAuthentication:
        state.isMapDraw = false
        return .run { send in
          let status = await self.userLocationUsecase.requestUserAuthorization()
          await send(.locationAuthorizationChanged(status))
        }
      case .locationAuthorizationChanged(let status):
        state.isMapDraw = true
        return .run { send in
          switch status {
          case .authorizedAlways, .authorizedWhenInUse:
            do {
              let location = try await self.userLocationUsecase.startUpdatingLocation()
              await send(.locationUpdated(location))
            } catch {
              await send(.setError((error as? MercuryError) ?? .init(from: .ownModule(.map), .unknown)))
            }
          default:
            break
          }
        }
      case .showAlert:
        state.isShowAlert = true
        return .none
      case .setUserLocation(let location):
        state.userLocation = location
        return .none
      case .locationUpdated(let location):
        state.userLocation = location.coordinate
        return .none
      }
    }
  }
  
}

