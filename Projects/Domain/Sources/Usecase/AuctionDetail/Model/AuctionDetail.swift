//
//  AuctionDetail.swift
//  Domain
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

public struct AuctionDetail: Sendable {
  /// 매물 상세 ID
  public let id: Int
  /// 매물 번호 (경매번호)
  public let salesNumber: String
  /// 매물 종류
  public let itemTypes: [ItemType]
  /// 감정가
  public let appraisalPrice: Int
  /// 최저 낙찰가
  public let lowestSalesPrice: Int
  /// 입찰 방식
  public let bidType: BidType
  /// 매각 기일
  public let salesDateTime: Date
  /// 매각 장소
  public let salesLocation: String
  /// 매각 비고
  public let salesNote: String
  /// 접수 마감일
  public let salesReceptionDate: Date
  /// 경매 개시일 일시
  public let salesOpenDate: Date
  /// 배당 요구 마감일
  public let distributionRequiredDeadlineDate: Date
  /// 매물 주소
  public let salesAddress: String
  /// 매물 카테고리 목록
  public let salesCategories: [SalesCategory]
  /// 유찰 횟수
  public let failBidCount: Int
  /// 찜 횟수
  public let zzimCount: Int
  /// 법원 정보
  public let court: Court
  /// 기일 내역
  public let salesDetails: [SalesDetail]
  /// 사진 목록
  public let salesPictures: [SalesPicture]
  /// 경매 상세 소재지 목록
  public let salesBuildings: [SalesBuilding]
  /// 경매 상세 목록 내역
  public let salesItemDetails: [SalesItemDetail]
  /// 현황 조사서
  public let conditionReport: ConditionReport
  /// 감정평가서 URL
  public let appraisalDocumentUrl: URL?
  /// 감정평가서
  public let appraisalDocuments: [AppraisalDocument]
  /// 인근 매각 통계
  public let nearbySalesStats: [NearbySalesStat]
  /// 낙찰 여부
  public let soldOut: Bool
  
  public init(id: Int, salesNumber: String, itemTypes: [ItemType], appraisalPrice: Int, lowestSalesPrice: Int, bidType: BidType, salesDateTime: Date, salesLocation: String, salesNote: String, salesReceptionDate: Date, salesOpenDate: Date, distributionRequiredDeadlineDate: Date, salesAddress: String, salesCategories: [SalesCategory], failBidCount: Int, zzimCount: Int, court: Court, salesDetails: [SalesDetail], salesPictures: [SalesPicture], salesBuildings: [SalesBuilding], salesItemDetails: [SalesItemDetail], conditionReport: ConditionReport, appraisalDocumentUrl: URL?, appraisalDocuments: [AppraisalDocument], nearbySalesStats: [NearbySalesStat], soldOut: Bool) {
    self.id = id
    self.salesNumber = salesNumber
    self.itemTypes = itemTypes
    self.appraisalPrice = appraisalPrice
    self.lowestSalesPrice = lowestSalesPrice
    self.bidType = bidType
    self.salesDateTime = salesDateTime
    self.salesLocation = salesLocation
    self.salesNote = salesNote
    self.salesReceptionDate = salesReceptionDate
    self.salesOpenDate = salesOpenDate
    self.distributionRequiredDeadlineDate = distributionRequiredDeadlineDate
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    self.court = court
    self.salesDetails = salesDetails
    self.salesPictures = salesPictures
    self.salesBuildings = salesBuildings
    self.salesItemDetails = salesItemDetails
    self.conditionReport = conditionReport
    self.appraisalDocumentUrl = appraisalDocumentUrl
    self.appraisalDocuments = appraisalDocuments
    self.nearbySalesStats = nearbySalesStats
    self.soldOut = soldOut
  }
  
  // MARK: - Enums
  
  /// 매물 종류 목록
  public enum ItemType: Sendable {
    /// 아파트
    case apartment
    ///
    case detachedHouse
    ///
    case multiHousehold
    ///
    case rowHouse
    ///
    case multiFamily
    ///
    case villa
    ///
    case automobile
    ///
    case heavyEquipment
    ///
    case land
    ///
    case forest
    ///
    case farmland
    ///
    case commercial
    ///
    case officeTel
    ///
    case neighborhoodFacility
    ///
    case other
    
    public init?(rawValue: String) {
      switch rawValue {
      case "APARTMENT": self = .apartment
      case "DETACHED_HOUSE": self = .detachedHouse
      case "MULTI_HOUSEHOLD": self = .multiHousehold
      case "ROW_HOUSE": self = .rowHouse
      case "MULTI_FAMILY": self = .multiFamily
      case "VILLA": self = .villa
      case "AUTOMOBILE": self = .automobile
      case "HEAVY_EQUIPMENT": self = .heavyEquipment
      case "LAND": self = .land
      case "FOREST": self = .forest
      case "FARMLAND": self = .farmland
      case "COMMERCIAL": self = .commercial
      case "OFFICE_TEL": self = .officeTel
      case "NEIGHBORHOOD_FACILITY": self = .neighborhoodFacility
      case "OTHER": self = .other
      default: return nil
      }
    }
  }
  
  /// 매물 카테고리
  public enum SalesCategory: String, Sendable {
    /// 주택
    case housing = "주택"
    /// 빌라
    case villa = "빌라"
    /// 아파트
    case apartment = "아파트"
    /// 상점
    case shopHouse = "상점"
    /// 오피스텔
    case officetel = "오피스텔"
    /// 기타
    case other = "기타"
    
    public init?(rawValue: String) {
      switch rawValue {
      case "HOUSING": self = .housing
      case "VILLA": self = .villa
      case "APARTMENT": self = .apartment
      case "SHOP_HOUSE": self = .shopHouse
      case "OFFICETEL": self = .officetel
      case "OTHER": self = .other
      default: return nil
      }
    }
  }
  
  /// 입찰 방식
  public enum BidType: Sendable {
    /// 일반 입찰
    case general
    /// 제한 입찰
    case limited
    /// 기타
    case other(String)
    
    public init(rawValue: String) {
      switch rawValue {
      case "일반입찰": self = .general
      case "제한입찰": self = .limited
      default: self = .other(rawValue)
      }
    }
  }
  
  // MARK: - Nested Structs
  
  /// 법원
  public struct Court: Sendable {
    /// 법원코드
    public let code: CourtCode
    /// 담당 팀명
    public let team: String
    
    public init(code: CourtCode, team: String) {
      self.code = code
      self.team = team
    }
    
    public enum CourtCode: Sendable {
      case seoulCentralDistrict // 서울중앙지방법원
      case seoulEasternDistrict // 서울동부지방법원
      case seoulWesternDistrict // 서울서부지방법원
      case seoulSouthernDistrict // 서울남부지방법원
      case seoulNorthernDistrict // 서울북부지방법원
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "SEOUL_CENTRAL_DISTRICT": self = .seoulCentralDistrict
        case "SEOUL_EASTERN_DISTRICT": self = .seoulEasternDistrict
        case "SEOUL_WESTERN_DISTRICT": self = .seoulWesternDistrict
        case "SEOUL_SOUTHERN_DISTRICT": self = .seoulSouthernDistrict
        case "SEOUL_NORTHERN_DISTRICT": self = .seoulNorthernDistrict
        default: self = .other(rawValue)
        }
      }
    }
    
    public var name: String {
      switch self.code {
      case .seoulCentralDistrict: return "서울중앙지방법원"
      case .seoulEasternDistrict: return "서울동부지방법원"
      case .seoulWesternDistrict: return "서울서부지방법원"
      case .seoulSouthernDistrict: return "서울남부지방법원"
      case .seoulNorthernDistrict: return "서울북부지방법원"
      case .other(let v): return v
      }
    }
  }
  
  /// 경매 상세 기일 정보
  public struct SalesDetail: Sendable {
    /// 기일
    public let timeStamp: Date
    /// 기일 종류
    public let type: SalesDetailType
    /// 기일 장소
    public let location: String
    /// 최저 낙찰가
    public let leastSalesPrice: Int
    /// 기일 결과
    public let result: SalesResult
    
    public init(timeStamp: Date, type: SalesDetailType, location: String, leastSalesPrice: Int, result: SalesResult) {
      self.timeStamp = timeStamp
      self.type = type
      self.location = location
      self.leastSalesPrice = leastSalesPrice
      self.result = result
    }
    
    public enum SalesDetailType: Sendable {
      case saleDate
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "매각기일": self = .saleDate
        default: self = .other(rawValue)
        }
      }
    }
    
    /// 기일 결과
    public enum SalesResult: Sendable {
      /// 경매 실패
      case failedBid
      /// 낙찰 완료
      case sold
      /// 경매 연기
      case postponed
      /// 경매 취소
      case canceled
      /// 기타
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "유찰": self = .failedBid
        case "낙찰": self = .sold
        case "연기": self = .postponed
        case "취소": self = .canceled
        default: self = .other(rawValue)
        }
      }
    }
  }

  /// 경매 상세 소재지 정보
  public struct SalesBuilding: Sendable {
    /// 주소 (시,구,동 ...)
    public let address: Address
    /// 상세 주소
    public let detailAddress: String
    ///소재지 구분 (소분류명)
    public let category: BuildingCategory
    
    public init(address: Address, detailAddress: String, category: BuildingCategory) {
      self.address = address
      self.detailAddress = detailAddress
      self.category = category
    }
    
    public struct Address: Sendable {
      public let siDo: String
      public let gu: String
      public let dong: String
      public let ri: String
      public let full: String
      
      public init(siDo: String, gu: String, dong: String, ri: String, full: String) {
        self.siDo = siDo
        self.gu = gu
        self.dong = dong
        self.ri = ri
        self.full = full
      }
    }
    
    public enum BuildingCategory: Sendable {
      /// 전용주거
      case exclusiveResidential
      /// 일반주거
      case generalResidential
      /// 상업
      case commercial
      /// 공업
      case industrial
      /// 기타
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "전용주거": self = .exclusiveResidential
        case "일반주거": self = .generalResidential
        case "상업": self = .commercial
        case "공업": self = .industrial
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  /// 목록 내역
  public struct SalesItemDetail: Sendable, Identifiable {
    public var id: Int { self.sequence }
    /// 목록 번호
    public let sequence: Int
    /// 목록 구분
    public let type: ItemDetailType
    /// 상세 내역
    public let content: String
    
    public init(sequence: Int, type: ItemDetailType, content: String) {
      self.sequence = sequence
      self.type = type
      self.content = content
    }
    
    public enum ItemDetailType: Sendable {
      /// 토지
      case land
      /// 건물
      case building
      /// 기타
      case other(String)
      
      public init(rawValue: String) {
        switch rawValue {
        case "토지": self = .land
        case "건물": self = .building
        default: self = .other(rawValue)
        }
      }
    }
  }
  
  /// 현황 조사서
  public struct ConditionReport: Sendable {
    /// 현황 조사일
    public let investigationDate: Date
    /// 부동산 임대차 정보
    public let estateLeaseInfos: [EstateLeaseInfo]
    /// 부동산 점유 관계
    public let occupationRelations: [OccupationRelation]
    /// 임대차 관계 조사서
    public let occupationRelationReports: [OccupationRelationReport]
    
    public init(investigationDate: Date, estateLeaseInfos: [EstateLeaseInfo], occupationRelations: [OccupationRelation], occupationRelationReports: [OccupationRelationReport]) {
      self.investigationDate = investigationDate
      self.estateLeaseInfos = estateLeaseInfos
      self.occupationRelations = occupationRelations
      self.occupationRelationReports = occupationRelationReports
    }
    
    /// 부동산 임대차 정보
    public struct EstateLeaseInfo: Sendable {
      /// 순번
      public let sequence: Int
      /// 주소
      public let address: String
      /// 임대차 관계
      public let leaseRelation: LeaseRelationType
      
      public init(sequence: Int, address: String, leaseRelation: LeaseRelationType) {
        self.sequence = sequence
        self.address = address
        self.leaseRelation = leaseRelation
      }
      
      /// 임대차 관계
      public enum LeaseRelationType: Sendable {
        /// 임차인
        case tenant
        /// 임대인
        case landlord
        /// 기타
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "임차인": self = .tenant
          case "임대인": self = .landlord
          default: self = .other(rawValue)
          }
        }
      }
    }
    
    /// 부동산 점유 관계
    public struct OccupationRelation: Sendable {
      /// 주소
      public let address: String
      /// 점유 관계
      public let relation: String
      /// 기타 정보
      public let etc: String
      
      public init(address: String, relation: String, etc: String) {
        self.address = address
        self.relation = relation
        self.etc = etc
      }
    }
    
    /// 임대차 관계 조사서
    public struct OccupationRelationReport: Sendable {
      /// 순번
      public let sequence: Int
      /// 소재지
      public let address: String
      /// 점유인
      public let occupant: String
      /// 당사자 구분(ex. 채무자)
      public let relation: OccupantRelation
      /// 점유 부분(ex. 4층403호)
      public let occupiedPart: String
      /// 용도(ex. 주거)
      public let purpose: OccupationPurpose
      /// 점유기간(ex. 2년)
      public let duration: String
      /// 보증(전세)금 (ex. 1000)
      public let deposit: Int
      /// 차임 (ex. 50)
      public let rental: Int
      /// 전입일자
      public let movedAt: Date
      /// 확정일자
      public let confirmedAt: Date
      
      public init(sequence: Int, address: String, occupant: String, relation: OccupantRelation, occupiedPart: String, purpose: OccupationPurpose, duration: String, deposit: Int, rental: Int, movedAt: Date, confirmedAt: Date) {
        self.sequence = sequence
        self.address = address
        self.occupant = occupant
        self.relation = relation
        self.occupiedPart = occupiedPart
        self.purpose = purpose
        self.duration = duration
        self.deposit = deposit
        self.rental = rental
        self.movedAt = movedAt
        self.confirmedAt = confirmedAt
      }
      
      public enum OccupantRelation: Sendable, Equatable {
        /// 채무자
        case debtor
        /// 임차인
        case tenant
        /// 소유자
        case owner
        /// 기타
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "채무자": self = .debtor
          case "임차인": self = .tenant
          case "소유자": self = .owner
          default: self = .other(rawValue)
          }
        }
      }
      
      public enum OccupationPurpose: Sendable {
        /// 주거
        case residential
        /// 상업
        case commercial
        /// 사무실
        case office
        /// 기타
        case other(String)
        
        public init(rawValue: String) {
          switch rawValue {
          case "주거": self = .residential
          case "상업": self = .commercial
          case "사무실": self = .office
          default: self = .other(rawValue)
          }
        }
      }
    }
  }
  
  /// 감정 평가서 요약
  public struct AppraisalDocument: Sendable {
    /// 순번
    public let sequence: Int
    /// 제목
    public let title: String
    /// 부제목
    public let subTitle: String
    /// 감정평가서 내용 (HTML)
    public let content: String
    
    public init(sequence: Int, title: String, subTitle: String, content: String) {
      self.sequence = sequence
      self.title = title
      self.subTitle = subTitle
      self.content = content
    }
  }
  
  /// 인근 매각 통계
  public struct NearbySalesStat: Sendable {
    /// 기간
    public let term: Int  // months
    /// 매각 건수
    public let salesCount: Int
    /// 평균 감정가
    public let averageAppraisalPrice: Int
    /// 평균 낙찰가
    public let averageSalesPrice: Int
    /// 매각가율
    public let salesPriceRate: Double  // percentage
    /// 평균 유찰 횟수
    public let averageFailBidCount: Double
    
    public init(term: Int, salesCount: Int, averageAppraisalPrice: Int, averageSalesPrice: Int, salesPriceRate: Double, averageFailBidCount: Double) {
      self.term = term
      self.salesCount = salesCount
      self.averageAppraisalPrice = averageAppraisalPrice
      self.averageSalesPrice = averageSalesPrice
      self.salesPriceRate = salesPriceRate
      self.averageFailBidCount = averageFailBidCount
    }
  }
}
