//
//  MapAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

public enum MapAPI {
  case loadProductCoordinate(courtSalesName: String, courtSalesAddress: String)
  case loadProductCoordinateList(courtSalesName: String, courtSalesAddress: String)
  case loadCourtSalesProducts(topLeftLatitude: Double, topLeftLongitude: Double, bottomRightLatitude: Double, bottomRightLongitude: Double)
}

extension MapAPI: BaseAPI {
  public var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  public var domain: String? {
    "v1/map/"
  }
  
  public var path: String {
    switch self {
    case .loadProductCoordinate:
      return "coordinate"
    case .loadProductCoordinateList:
      return "coordinate-list"
    case .loadCourtSalesProducts:
      return "court-sales-list"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .loadProductCoordinate:
      return .post
    case .loadProductCoordinateList:
      return .post
    case .loadCourtSalesProducts:
      return .get
    }
  }
  
  public var requestBody: [String : Any]? {
    switch self {
    case let .loadProductCoordinate(courtSalesName, courtSalesAddress):
      return [
        "courtSalesName": courtSalesName,
        "courtSalesAddress": courtSalesAddress
      ]
    case let .loadProductCoordinateList(courtSalesName, courtSalesAddress):
      return [
        "courtSalesName": courtSalesName,
        "courtSalesAddress": courtSalesAddress
      ]
    case .loadCourtSalesProducts:
      return nil
    }
  }
  
  public var queryParam: [String : Any]? {
    switch self {
    case .loadProductCoordinate:
      return nil
    case .loadProductCoordinateList:
      return nil
    case let .loadCourtSalesProducts(topLeftLatitude, topLeftLongitude, bottomRightLatitude, bottomRightLongitude):
      return [
        "topLeftLatitude": topLeftLatitude,
        "topLeftLongitude": topLeftLongitude,
        "bottomRightLatitude": bottomRightLatitude,
        "bottomRightLongitude": bottomRightLongitude
      ]
    }
  }
  
  
}
