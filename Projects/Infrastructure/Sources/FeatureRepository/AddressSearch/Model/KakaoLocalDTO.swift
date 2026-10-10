//
//  KakaoLocalDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

/// 카카오 로컬 API 응답 (`documents` 배열 공통)
struct KakaoLocalResponseDTO<Document: Decodable>: Decodable {
  let documents: [Document]
}
