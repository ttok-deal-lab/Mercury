//
//  SampleAuctionInterestUsecase.swift
//  AuctionDetailSampleApp
//
//  찜(관심) 기능은 인증이 필요하므로 미리보기에서는 동작하지 않는 stub 으로 대체한다.
//

import Foundation

import Domain

struct SampleAuctionInterestUsecase: AuctionInterestUsecasable {

  func isAuctionInterested(auctionID: Int) async throws -> Bool { false }
  func addInterest(auctionID: Int) async throws { }
  func removeInterest(auctionID: Int) async throws { }
  func resetPagination() async { }
  func loadInterest() async throws -> [InterestItem] { [] }
  func loadNextInterest() async throws -> [InterestItem] { [] }
  func loadInterestList(ids: [Int]) async throws -> [InterestWhether] { [] }
}
