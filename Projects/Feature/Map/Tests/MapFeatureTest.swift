//
//  MapFeatureTest.swift
//  MapTests
//
//  Created by 송하민 on 9/21/24.
//

import Foundation
import AppFoundation
import Testing
import XCTest
import ComposableArchitecture
import CoreLocation
@testable import Map

@MainActor
@Suite("Map Feature 테스트")
struct MapFeatureTest {

  @MainActor
  @Suite("No Effect Tests")
  struct MapFeature_No_Effect_Test {
    
    @Test("Test set `isMapDraw`: initialized with true")
    func test_MapDraw_1() async {
      let store = TestStore(initialState: MapFeature.State(isMapDraw: true)) {
        MapFeature()
      }
      await store.send(.setDrawMap(false)) {
        $0.isMapDraw = false
      }
    }
    @Test("Test set `isMapDraw`: initialized with false")
    func test_MapDraw_2() async {
      let store = TestStore(initialState: MapFeature.State(isMapDraw: false)) {
        MapFeature()
      }
      await store.send(.setDrawMap(true)) {
        $0.isMapDraw = true
      }
    }
    
    @Test("Test set `isShowDeniedLocationAlert`: initialized with true")
    func test_isShowDeniedLocationAlert_1() async {
      let store = TestStore(initialState: MapFeature.State(isShowDeniedLocationAlert: true)) {
        MapFeature()
      }
      await store.send(.setIsShowDeniedLocationAlert(false)) {
        $0.isShowDeniedLocationAlert = false
      }
    }
    @Test("Test set `isShowDeniedLocationAlert`: initialized with false")
    func test_isShowDeniedLocationAlert_2() async {
      let store = TestStore(initialState: MapFeature.State(isShowDeniedLocationAlert: false)) {
        MapFeature()
      }
      await store.send(.setIsShowDeniedLocationAlert(true)) {
        $0.isShowDeniedLocationAlert = true
      }
    }
    
    @Test("Test set `userLocation`")
    func test_userLocation() async {
      let store = TestStore(initialState: MapFeature.State()) {
        MapFeature()
      }
      await store.send(.setUserLocation(.init(latitude: 100.0000, longitude: 200.0000))) {
        $0.userLocation = .init(latitude: 100.0000, longitude: 200.0000)
      }
    }
    
    @Test("Test set `cameraCenterLocation`")
    func test_cameraCenterLocation() async {
      let store = TestStore(initialState: MapFeature.State()) {
        MapFeature()
      }
      await store.send(.setCameraCenterLocation(.init(latitude: 100.0000, longitude: 200.0000))) {
        $0.cameraCenterLocation = .init(latitude: 100.0000, longitude: 200.0000)
      }
    }
  }
  
  @MainActor
  @Suite("Effect Tests")
  struct MapFeature_Effect_Test {
    
    @Test("Test checkUserAuthorization: .notDetermined")
    func test_checkUserAuthorization_notDetermined() async {
      await withDependencies {
        $0.userLocationClient.userAuthorization = { .notDetermined }
      } operation: {
        let store = TestStore(initialState: MapFeature.State()) {
          MapFeature()
        }
        
        await store.send(.checkUserAuthorization)
        await store.receive(.requestLocationAuthentication)
      }
    }
    
    @Test("Test checkUserAuthorization: .denied")
    func test_checkUserAuthorization_denied() async {
      await withDependencies {
        $0.userLocationClient.userAuthorization = { .denied }
      } operation: {
        let store = TestStore(initialState: MapFeature.State()) {
          MapFeature()
        }
        
        await store.send(.checkUserAuthorization)
        await store.receive(.setIsShowDeniedLocationAlert(true)) {
          $0.isShowDeniedLocationAlert = true
        }
      }
    }
    
    @Test("Test checkUserAuthorization: .authorizedWhenInUse")
    func test_checkUserAuthorization_authorized() async {
      let mockLocation = CLLocationCoordinate2D(latitude: 111.1111, longitude: 111.1111)
      await withDependencies {
        $0.userLocationClient.userAuthorization = { .authorizedWhenInUse }
        $0.userLocationClient.userCurrentLocation = { mockLocation }
      } operation: {
        let store = TestStore(initialState: MapFeature.State()) {
          MapFeature()
        }
        
        await store.send(.checkUserAuthorization)
        await store.receive(.updateUserLocation)
        await store.receive(.setUserLocation(mockLocation)) {
          $0.userLocation = mockLocation
        }
      }
    }
    
    @Test("Test checkUserAuthorization: unknown status")
    func test_checkUserAuthorization_unknown() async {
      await withDependencies {
        $0.userLocationClient.userAuthorization = {
          CLAuthorizationStatus(rawValue: 999)! // 존재하지 않는 상태
        }
      } operation: {
        let store = TestStore(initialState: MapFeature.State()) {
          MapFeature()
        }
        
        await store.send(.checkUserAuthorization)
        await store.receive(.setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus))) {
          $0.error = .init(from: .ownModule(.map), .unknownLocationAuthenticationStatus)
        }
      }
    }
  }
  
}

