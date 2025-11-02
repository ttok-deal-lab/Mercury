//
//  AuctionDetailAbstractInfoView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

fileprivate enum EasyInformation: String, Identifiable {
  var id: Self { self }
  
  /// 최저 매각 가격
  case minimum_sale_price
  /// 감정가
  case estimated_value
  
}

struct AuctionDetailAbstractInfoView: View {
  
  @State private var showEasyInfoType: EasyInformation?
  let item: AuctionDetail
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: 12) {
        VStack(alignment: .leading, spacing: 6) {
          titleView()
          categoryWithCapacityView()
          auctionNumberView()
        }
        Spacer()
        ZzimButtonView(isZzimed: false, item: item)
      }
      .padding(.bottom, 16)
      
      auctionChipView()
        .padding(.bottom, 16)
      
      VStack(spacing: .zero) {
        HStack(spacing: .zero) {
          Button {
            showEasyInfoType = .minimum_sale_price
          } label: {
            HStack(spacing: .zero) {
              HStack(spacing: 3) {
                Text("최저매각가격")
                  .fonts(.bodySmallMedium)
                  .foregroundStyle(Asset.Colors.neutralSubtler.color)
                Asset.Images.infoLine.image
                  .resizable()
                  .frame(width: 16, height: 16)
              }
              Spacer()
            }
          }
          Spacer()
          Text("1억 8,320만원")
            .fonts(.titleMediumBold)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
        Spacer()
        
        HStack(spacing: 2) {
          Spacer()
          Text("감정가대비")
            .fonts(.bodyMicroMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Text("-4,800만원 (10.84%)")
            .fonts(.bodyMicroMedium)
            .foregroundStyle(Asset.Colors.primary.color)
        }
        
        VStack(spacing: 12) {
          /// 감정가
          HStack(spacing: .zero) {
            Button {
              showEasyInfoType = .estimated_value
            } label: {
              HStack(spacing: .zero) {
                HStack(spacing: 3) {
                  Text("감정가")
                    .fonts(.bodySmallMedium)
                    .foregroundStyle(Asset.Colors.neutralSubtler.color)
                  Asset.Images.infoLine.image
                    .resizable()
                    .frame(width: 16, height: 16)
                  
                  Spacer()
                }
              }
            }
            Spacer()
            Text("2억 3,000만원")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
          
          HStack(spacing: .zero) {
            HStack(spacing: 4) {
              Text("최근실거래가")
                .fonts(.bodySmallMedium)
                .foregroundStyle(Asset.Colors.neutralSubtler.color)
              Text("(25.03.16)")
                .fonts(.bodyMicroRegular)
                .foregroundStyle(Asset.Colors.neutralSubtler.color)
            }
            Spacer()
            Text("5억 5,421만원")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
          
          HStack(spacing: .zero) {
            Text("매각기일")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
            Spacer()
            Text("2025.04.08 10:00")
              .fonts(.bodyLargeBold)
              .foregroundStyle(Asset.Colors.neutral.color)
          }
        }
        .background(Asset.Colors.gray150.color)
        
      }
      .padding(16)
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 1)
          .foregroundStyle(Asset.Colors.gray150.color)
      }
      
    }
    .padding(20)
    .sheet(item: $showEasyInfoType) { type in
      switch type {
      case .minimum_sale_price:
        Text("최저매각가격이란? 시트")
          .dynamicSheet()
      case .estimated_value:
        Text("감정가 시트")
          .dynamicSheet()
      }
    }
  }
  
  /// 물건 이름
  private func titleView() -> some View {
    Text("\(item.salesBuildings[0].detailAddress)")
      .fonts(.titleLargeBold)
      .foregroundStyle(Asset.Colors.neutral.color)
      .multilineTextAlignment(.leading)
  }
  
  /// 카테고리 및 공급(평형)
  private func categoryWithCapacityView() -> some View {
    HStack(spacing: .zero) {
      Text("아파트")
      Text("ㅣ")
      Text("공급 110.52㎡ (33평)")
    }
    .fonts(.bodyMiniMedium)
    .foregroundStyle(Asset.Colors.neutralSubtler.color)
  }
  
  /// 사건 번호
  private func auctionNumberView() -> some View {
    Button {
      UIPasteboard.general.string = "2023타경 102411"
    } label: {
      HStack(spacing: 2) {
        Text("매물번호 2023타경 102411")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        
        Asset.Images.copy.image
          .resizable()
          .frame(width: 18, height: 18)
      }
    }
  }
  
  /// 물건 칩
  private func auctionChipView() -> some View {
    HStack(spacing: 4) {
      HStack(spacing: 4) {
        Asset.Images.certified.image
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.white)
          .frame(width: 16, height: 16)
        Text("인증매물")
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .fonts(.bodyMicroMedium)
      }
      .frame(height: 24)
      .padding(.horizontal, 6)
      .background {
        LinearGradient(colors: [Asset.Colors.commonGradientStart.color, Asset.Colors.commonGradientEnd.color], startPoint: .topLeading, endPoint: .bottomTrailing)
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("유찰 2회")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-2")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.critical.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.criticalWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-4")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Spacer()
    }
  }
  
}
#Preview {
  AuctionDetailAbstractInfoView(item: AuctionDetail(
    id: 1,
    salesNumber: "2024타경12345",
    itemTypes: [.apartment],
    appraisalPrice: 850_000_000,
    lowestSalesPrice: 595_000_000,  // 감정가의 70%
    bidType: .general,
    salesDateTime: Date().addingTimeInterval(86400 * 14), // 14일 후
    salesLocation: "서울중앙지방법원 동관 3층 311호 법정",
    salesNote: "※ 본 물건은 입찰보증금 10% 납부 필요\n※ 임차인 있음 (전세보증금 3억원)\n※ 인도명령 가능",
    salesReceptionDate: Date().addingTimeInterval(86400 * 7), // 7일 후
    salesOpenDate: Date().addingTimeInterval(86400 * 10), // 10일 후
    distributionRequiredDeadlineDate: Date().addingTimeInterval(86400 * 60), // 60일 후
    salesAddress: "서울특별시 강남구 삼성동 123-45 래미안아파트 101동 1502호",
    salesCategories: [.apartment],
    failBidCount: 2,
    zzimCount: 156,
    court: AuctionDetail.Court(
      code: .seoulCentralDistrict,
      team: "21계"
    ),
    salesDetails: [
      AuctionDetail.SalesDetail(
        timeStamp: Date().addingTimeInterval(-86400 * 60), // 60일 전
        type: .saleDate,
        location: "서울중앙지방법원 동관 3층 311호",
        leastSalesPrice: 850_000_000,
        result: .failedBid
      ),
      AuctionDetail.SalesDetail(
        timeStamp: Date().addingTimeInterval(-86400 * 30), // 30일 전
        type: .saleDate,
        location: "서울중앙지방법원 동관 3층 311호",
        leastSalesPrice: 680_000_000,
        result: .failedBid
      )
    ],
    salesPictures: [
      AuctionDetail.SalesPicture(
        sequence: 1,
        imageUrl: URL(string: "https://example.com/images/auction_1_front.jpg")
      ),
      AuctionDetail.SalesPicture(
        sequence: 2,
        imageUrl: URL(string: "https://example.com/images/auction_1_living.jpg")
      ),
      AuctionDetail.SalesPicture(
        sequence: 3,
        imageUrl: URL(string: "https://example.com/images/auction_1_kitchen.jpg")
      ),
      AuctionDetail.SalesPicture(
        sequence: 4,
        imageUrl: URL(string: "https://example.com/images/auction_1_room1.jpg")
      )
    ],
    salesBuildings: [
      AuctionDetail.SalesBuilding(
        address: AuctionDetail.SalesBuilding.Address(
          siDo: "서울특별시",
          gu: "강남구",
          dong: "삼성동",
          ri: "",
          full: "서울특별시 강남구 삼성동 123-45"
        ),
        detailAddress: "래미안아파트 101동 1502호",
        category: .generalResidential
      )
    ],
    salesItemDetails: [
      AuctionDetail.SalesItemDetail(
        sequence: 1,
        type: .land,
        content: "대지권 35.2345㎡"
      ),
      AuctionDetail.SalesItemDetail(
        sequence: 2,
        type: .building,
        content: "전용면적 84.95㎡, 일반분양면적 109.85㎡, 서비스면적 25.32㎡"
      ),
      AuctionDetail.SalesItemDetail(
        sequence: 3,
        type: .other("구조"),
        content: "철근콘크리트구조, 2008년 준공"
      ),
      AuctionDetail.SalesItemDetail(
        sequence: 4,
        type: .other("용도지역"),
        content: "제3종일반주거지역"
      )
    ],
    conditionReport: AuctionDetail.ConditionReport(
      investigationDate: Date().addingTimeInterval(-86400 * 7), // 7일 전 조사
      estateLeaseInfos: [
        AuctionDetail.ConditionReport.EstateLeaseInfo(
          sequence: 1,
          address: "서울특별시 강남구 삼성동 123-45 래미안아파트 101동 1502호",
          leaseRelation: .tenant
        )
      ],
      occupationRelations: [
        AuctionDetail.ConditionReport.OccupationRelation(
          address: "서울특별시 강남구 삼성동 123-45 래미안아파트 101동 1502호",
          relation: "임차인 거주중",
          etc: "전세계약서 확인, 확정일자 있음"
        )
      ],
      occupationRelationReports: [
        AuctionDetail.ConditionReport.OccupationRelationReport(
          sequence: 1,
          address: "서울특별시 강남구 삼성동 123-45 래미안아파트 101동 1502호",
          occupant: "김○○",
          relation: .tenant,
          occupiedPart: "전체",
          purpose: .residential,
          duration: "2023.03.15 ~ 2025.03.14",
          deposit: 300_000_000,
          rental: 0,
          movedAt: Date().addingTimeInterval(-86400 * 600), // 600일 전 입주
          confirmedAt: Date().addingTimeInterval(-86400 * 598) // 598일 전 확정일자
        )
      ]
    ),
    appraisalDocumentUrl: URL(string: "https://example.com/documents/appraisal_2024_12345.pdf"),
    appraisalDocuments: [
      AuctionDetail.AppraisalDocument(
        sequence: 1,
        title: "위치 및 환경",
        subTitle: "입지조건",
        content: "본 물건은 강남구 삼성동 중심상업지구 인근에 위치하며, 지하철 2호선 삼성역에서 도보 10분 거리에 있음. 주변에 대형마트, 병원, 학교 등 생활편의시설이 잘 갖춰져 있음."
      ),
      AuctionDetail.AppraisalDocument(
        sequence: 2,
        title: "건물현황",
        subTitle: "건물상태",
        content: "2008년 준공된 아파트로 관리상태 양호함. 최근 엘리베이터 교체공사 완료. 주차장은 지하 2층, 지상 1층으로 구성되어 있으며 세대당 1.2대 주차 가능."
      ),
      AuctionDetail.AppraisalDocument(
        sequence: 3,
        title: "권리관계",
        subTitle: "권리분석",
        content: "근저당권 설정액 5억원 (채권자: ○○은행), 전세권 설정 3억원. 가압류, 가처분 등 기타 권리관계 없음."
      ),
      AuctionDetail.AppraisalDocument(
        sequence: 4,
        title: "시세분석",
        subTitle: "인근 실거래가",
        content: "동일 단지 내 최근 6개월 실거래가 평균 8.5억~9.2억원. 전세가 평균 5.5억~6억원으로 형성."
      )
    ],
    nearbySalesStats: [
      AuctionDetail.NearbySalesStat(
        term: 3,  // 3개월
        salesCount: 5,
        averageAppraisalPrice: 820_000_000,
        averageSalesPrice: 738_000_000,
        salesPriceRate: 90.0,
        averageFailBidCount: 1.4
      ),
      AuctionDetail.NearbySalesStat(
        term: 6,  // 6개월
        salesCount: 12,
        averageAppraisalPrice: 835_000_000,
        averageSalesPrice: 760_500_000,
        salesPriceRate: 91.1,
        averageFailBidCount: 1.8
      ),
      AuctionDetail.NearbySalesStat(
        term: 12,  // 12개월
        salesCount: 28,
        averageAppraisalPrice: 810_000_000,
        averageSalesPrice: 745_200_000,
        salesPriceRate: 92.0,
        averageFailBidCount: 2.1
      )
    ],
    soldOut: false
  ))
}
