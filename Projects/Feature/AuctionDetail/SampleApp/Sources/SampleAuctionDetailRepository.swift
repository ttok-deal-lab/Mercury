//
//  SampleAuctionDetailRepository.swift
//  AuctionDetailSampleApp
//
//  네트워크 대신 고정 데이터를 돌려주는 미리보기용 Repository.
//

import Foundation

import Domain

struct SampleAuctionDetailRepository: AuctionDetailRepositorable {

  func auctionDetail(auctionID: Int) async throws -> AuctionDetail {
    SampleAuctionDetail.make()
  }

  func auctionDetails(auctionIDs: [Int], size: Int) async throws -> [AuctionDetail] {
    [SampleAuctionDetail.make()]
  }
}
