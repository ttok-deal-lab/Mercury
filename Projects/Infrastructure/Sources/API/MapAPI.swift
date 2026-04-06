//
//  MapAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation
import CoreLocation

import Networking

enum MapAPI {
  case loadProductCoordinate(courtSalesName: String, courtSalesAddress: String)
  case loadProductCoordinateList(courtSalesName: String, courtSalesAddress: String)
  case loadCourtSalesProducts(topLeftLatitude: Double, topLeftLongitude: Double, bottomRightLatitude: Double, bottomRightLongitude: Double)
}

extension MapAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    "v1/map/"
  }
  
  var path: String {
    switch self {
    case .loadProductCoordinate:
      return "coordinate"
    case .loadProductCoordinateList:
      return "coordinate-list"
    case .loadCourtSalesProducts:
      return "court-sales-list"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .loadProductCoordinate:
      return .post
    case .loadProductCoordinateList:
      return .post
    case .loadCourtSalesProducts:
      return .get
    }
  }
  
  var requestBody: [String : Any]? {
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
  
  var queryParam: [String : Any]? {
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

public struct ProductCoordinateService {
  public init() { }
  
  public func coordinate(name: String, address: String) async -> CLLocationCoordinate2D? {
    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
    let trimmedAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmedAddress.isEmpty else { return nil }
    
    do {
      let response = try await MapAPI.loadProductCoordinate(
        courtSalesName: trimmedName.isEmpty ? trimmedAddress : trimmedName,
        courtSalesAddress: trimmedAddress
      ).request(ProductCoordinateResponseDTO.self)
      return response.coordinate
    } catch {
      return nil
    }
  }
}

private struct ProductCoordinateResponseDTO: Decodable {
  let latitude: Double
  let longitude: Double
  
  var coordinate: CLLocationCoordinate2D {
    CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
  }
  
  init(from decoder: Decoder) throws {
    if let decoded = try Self.decode(from: decoder) {
      self = decoded
      return
    }
    
    throw DecodingError.dataCorrupted(
      .init(codingPath: decoder.codingPath, debugDescription: "Failed to decode product coordinate response.")
    )
  }
  
  private static func decode(from decoder: Decoder) throws -> Self? {
    let container = try decoder.container(keyedBy: DynamicCodingKey.self)
    
    if let coordinate = try decodeCoordinate(in: container) {
      return coordinate
    }
    
    for nestedKey in ["data", "result", "coordinate", "item"] {
      guard let codingKey = DynamicCodingKey(stringValue: nestedKey) else { continue }
      if container.contains(codingKey),
         let nestedCoordinate = try? container.decode(ProductCoordinateResponseDTO.self, forKey: codingKey) {
        return nestedCoordinate
      }
    }
    
    return nil
  }
  
  private static func decodeCoordinate(
    in container: KeyedDecodingContainer<DynamicCodingKey>
  ) throws -> Self? {
    let latitude = try decodeDouble(
      forKeys: ["latitude", "lat", "y", "yCoordinate", "mapY"],
      in: container
    )
    let longitude = try decodeDouble(
      forKeys: ["longitude", "lng", "lon", "x", "xCoordinate", "mapX"],
      in: container
    )
    
    guard let latitude, let longitude else { return nil }
    return .init(latitude: latitude, longitude: longitude)
  }
  
  private static func decodeDouble(
    forKeys keys: [String],
    in container: KeyedDecodingContainer<DynamicCodingKey>
  ) throws -> Double? {
    for key in keys {
      guard let codingKey = DynamicCodingKey(stringValue: key) else { continue }
      if let doubleValue = try container.decodeIfPresent(Double.self, forKey: codingKey) {
        return doubleValue
      }
      if let stringValue = try container.decodeIfPresent(String.self, forKey: codingKey),
         let doubleValue = Double(stringValue) {
        return doubleValue
      }
      if let intValue = try container.decodeIfPresent(Int.self, forKey: codingKey) {
        return Double(intValue)
      }
    }
    
    return nil
  }
  
  private init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

private struct DynamicCodingKey: CodingKey {
  var stringValue: String
  var intValue: Int?
  
  init?(stringValue: String) {
    self.stringValue = stringValue
    self.intValue = nil
  }
  
  init?(intValue: Int) {
    return nil
  }
}
