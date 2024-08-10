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
      return lhs.locationAuthorizationStatus?.rawValue == rhs.locationAuthorizationStatus?.rawValue &&
      lhs.userLocation?.latitude == rhs.userLocation?.latitude &&
      lhs.userLocation?.longitude == rhs.userLocation?.longitude
    }
    
    public var locationAuthorizationStatus: CLAuthorizationStatus?
    public var error: MercuryError?
    public var userLocation: CLLocationCoordinate2D?
    public var isShowAlert: Bool = false
    public var draw: Bool = false
    
    public init() {
      
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case checkUserAuthorization
    case setAuthenticationStatus(CLAuthorizationStatus)
    case setError(MercuryError)
    case requestLocationAuthentication
    case showAlert
    case setUserLocation(CLLocationCoordinate2D)
    
  }
  
  private var cancellables = Set<AnyCancellable>()
  @Dependency(\.locationAuthorizationUsecase) var locationAuthorizationUsecase
  
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .checkUserAuthorization:
        return .run { send in
          let authStatusResult = await self.locationAuthorizationUsecase.userAuthorization()
          switch authStatusResult {
          case .success(let status):
            await send(.setAuthenticationStatus(status))
          case .failure(let error):
            await send(.setError(error))
          }
        }
        
      case .setAuthenticationStatus(let status):
        state.locationAuthorizationStatus = status
        switch status {
        case .notDetermined, .restricted:
          return .send(.requestLocationAuthentication)
        case .denied:
          return .send(.showAlert)
        case .authorizedAlways, .authorizedWhenInUse:
          let userLocation = self.locationAuthorizationUsecase.userCurrentLocation()
          guard let coordinate = userLocation?.coordinate else {
            return .send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
          }
          return .send(.setUserLocation(coordinate))
        @unknown default:
          return .send(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)))
        }
        return .none
      case .setError(let error):
        state.error = error
        return .none
      case .requestLocationAuthentication:
        self.locationAuthorizationUsecase.requestUserAuthorization()
        return .none
      case .showAlert:
        state.isShowAlert = true
        return .none
      case .setUserLocation(let location):
        state.userLocation = location
        return .none
     
      }
      
    }
  }
  
}

