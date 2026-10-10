//
//  KakaoJibunAddressDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

struct KakaoJibunAddressDTO: Decodable {
  let addressName: String
  let region1DepthName: String
  let region2DepthName: String
  let region3DepthName: String
  
  enum CodingKeys: String, CodingKey {
    case addressName = "address_name"
    case region1DepthName = "region_1depth_name"
    case region2DepthName = "region_2depth_name"
    case region3DepthName = "region_3depth_name"
  }
}
