//
//  AuctionSalesListRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation
import Domain

public final class AuctionSalesListRepository: AuctionSalesListRepositorable {
  
  public init() {
    
  }
  
  public func fetchAuctionSales(cursor: String?, size: Int) async throws -> AuctionSales {
    
    // 일단 mock 사용
    return AuctionSales(items: self.mockAuctionSalesItems, nextCursor: nil, hasNext: false)
    
//    let auctionSalesItemDTO = try await AuctionAPI.auctionList(cursor: cursor, size: size)
//      .request(AuctionSalesDTO.self)
//    let auctionItems = auctionSalesItemDTO.toEntity()
//    return auctionItems
  }
}

extension AuctionSalesListRepository {
  var mockAuctionSalesItems: [AuctionSalesItem] {
    [
      AuctionSalesItem(
        id: 1,
        salesAddress: "서울특별시 강남구 삼성동 123-45 래미안아파트 101동 502호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 7), // 7일 후
        appraisalPrice: "850,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction1.jpg"),
        failBidCount: 0,
        zzimCount: 42
      ),
      AuctionSalesItem(
        id: 2,
        salesAddress: "경기도 성남시 분당구 정자동 456-78 더샵 203동 1502호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 14),
        appraisalPrice: "1,200,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction2.jpg"),
        failBidCount: 2,
        zzimCount: 128
      ),
      AuctionSalesItem(
        id: 3,
        salesAddress: "서울특별시 마포구 상암동 789-12",
        itemTypes: [.villa],
        salesCategories: [.villa],
        salesDate: Date().addingTimeInterval(86400 * 5),
        appraisalPrice: "450,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction3.jpg"),
        failBidCount: 1,
        zzimCount: 35
      ),
      AuctionSalesItem(
        id: 4,
        salesAddress: "인천광역시 연수구 송도동 234-56 오피스텔 A동 807호",
        itemTypes: [.officetel],
        salesCategories: [.office_tel],
        salesDate: Date().addingTimeInterval(86400 * 10),
        appraisalPrice: "320,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction4.jpg"),
        failBidCount: 0,
        zzimCount: 18
      ),
      AuctionSalesItem(
        id: 5,
        salesAddress: "경기도 용인시 수지구 동천동 345-67",
        itemTypes: [.housing],
        salesCategories: [.detached_house],
        salesDate: Date().addingTimeInterval(86400 * 21),
        appraisalPrice: "680,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction5.jpg"),
        failBidCount: 3,
        zzimCount: 56
      ),
      AuctionSalesItem(
        id: 6,
        salesAddress: "서울특별시 서초구 방배동 891-23 상가건물 1층",
        itemTypes: [.shop_house],
        salesCategories: [.commercial],
        salesDate: Date().addingTimeInterval(86400 * 3),
        appraisalPrice: "2,100,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction6.jpg"),
        failBidCount: 1,
        zzimCount: 89
      ),
      AuctionSalesItem(
        id: 7,
        salesAddress: "부산광역시 해운대구 우동 567-89 마린시티 B동 2103호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 15),
        appraisalPrice: "950,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction7.jpg"),
        failBidCount: 0,
        zzimCount: 156
      ),
      AuctionSalesItem(
        id: 8,
        salesAddress: "대전광역시 유성구 봉명동 123-45",
        itemTypes: [.villa],
        salesCategories: [.multi_family],
        salesDate: Date().addingTimeInterval(86400 * 8),
        appraisalPrice: "380,000,000",
        salesPictureURL: nil,
        failBidCount: 2,
        zzimCount: 27
      ),
      AuctionSalesItem(
        id: 9,
        salesAddress: "강원도 춘천시 효자동 234-56 (토지)",
        itemTypes: [.other],
        salesCategories: [.land],
        salesDate: Date().addingTimeInterval(86400 * 30),
        appraisalPrice: "250,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction9.jpg"),
        failBidCount: 4,
        zzimCount: 12
      ),
      AuctionSalesItem(
        id: 10,
        salesAddress: "제주특별자치도 서귀포시 중문동 789-12",
        itemTypes: [.housing],
        salesCategories: [.detached_house],
        salesDate: Date().addingTimeInterval(86400 * 12),
        appraisalPrice: "890,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction10.jpg"),
        failBidCount: 0,
        zzimCount: 234
      ),
      AuctionSalesItem(
        id: 11,
        salesAddress: "경기도 파주시 교하동 345-67 (농지)",
        itemTypes: [.other],
        salesCategories: [.farmland],
        salesDate: Date().addingTimeInterval(86400 * 18),
        appraisalPrice: "180,000,000",
        salesPictureURL: nil,
        failBidCount: 1,
        zzimCount: 8
      ),
      AuctionSalesItem(
        id: 12,
        salesAddress: "서울특별시 송파구 잠실동 234-56 엘스 107동 1801호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 9),
        appraisalPrice: "1,850,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction12.jpg"),
        failBidCount: 1,
        zzimCount: 298
      ),
      AuctionSalesItem(
        id: 13,
        salesAddress: "대구광역시 수성구 범어동 567-89",
        itemTypes: [.villa],
        salesCategories: [.row_house],
        salesDate: Date().addingTimeInterval(86400 * 6),
        appraisalPrice: "420,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction13.jpg"),
        failBidCount: 0,
        zzimCount: 31
      ),
      AuctionSalesItem(
        id: 14,
        salesAddress: "경기도 의정부시 민락동 123-45 상가 2층",
        itemTypes: [.shop_house],
        salesCategories: [.neighborhood_facility],
        salesDate: Date().addingTimeInterval(86400 * 11),
        appraisalPrice: "580,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction14.jpg"),
        failBidCount: 2,
        zzimCount: 45
      ),
      AuctionSalesItem(
        id: 15,
        salesAddress: "울산광역시 남구 삼산동 890-12 (중장비 보관소)",
        itemTypes: [.other],
        salesCategories: [.heavy_equipment],
        salesDate: Date().addingTimeInterval(86400 * 25),
        appraisalPrice: "95,000,000",
        salesPictureURL: nil,
        failBidCount: 5,
        zzimCount: 3
      ),
      AuctionSalesItem(
        id: 16,
        salesAddress: "서울특별시 노원구 상계동 456-78 주공아파트 5단지 502동 305호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 4),
        appraisalPrice: "520,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction16.jpg"),
        failBidCount: 0,
        zzimCount: 67
      ),
      AuctionSalesItem(
        id: 17,
        salesAddress: "광주광역시 서구 치평동 234-56",
        itemTypes: [.officetel],
        salesCategories: [.office_tel],
        salesDate: Date().addingTimeInterval(86400 * 13),
        appraisalPrice: "285,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction17.jpg"),
        failBidCount: 1,
        zzimCount: 22
      ),
      AuctionSalesItem(
        id: 18,
        salesAddress: "경상남도 창원시 마산합포구 해운동 678-90 (임야)",
        itemTypes: [.other],
        salesCategories: [.forest],
        salesDate: Date().addingTimeInterval(86400 * 35),
        appraisalPrice: "120,000,000",
        salesPictureURL: nil,
        failBidCount: 3,
        zzimCount: 5
      ),
      AuctionSalesItem(
        id: 19,
        salesAddress: "서울특별시 중구 명동 123-45 오피스빌딩 8층",
        itemTypes: [.other],
        salesCategories: [.commercial, .office_tel],
        salesDate: Date().addingTimeInterval(86400 * 2),
        appraisalPrice: "3,200,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction19.jpg"),
        failBidCount: 0,
        zzimCount: 412
      ),
      AuctionSalesItem(
        id: 20,
        salesAddress: "경기도 화성시 동탄 789-12 동탄역 파크뷰 301동 1205호",
        itemTypes: [.apartment],
        salesCategories: [.apartment],
        salesDate: Date().addingTimeInterval(86400 * 16),
        appraisalPrice: "780,000,000",
        salesPictureURL: URL(string: "https://example.com/images/auction20.jpg"),
        failBidCount: 1,
        zzimCount: 94
      )
    ]
  }
}
