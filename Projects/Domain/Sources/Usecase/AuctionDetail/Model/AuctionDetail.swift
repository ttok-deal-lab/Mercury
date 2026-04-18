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
  public enum ItemType: String, Sendable {
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
  public enum SalesCategory: Sendable {
    // MARK: 토지/지목
    case land
    case landDesignation
    case field
    case paddy
    case orchard
    case ranchLand
    case forestLand
    case mineralSpringLand
    case saltPan
    case buildingSite
    case factorySite
    case schoolSite
    case parkingLot
    case gasStationSite
    case warehouseSite
    case road
    case railwaySite
    case embankment
    case river
    case ditch
    case reservoir
    case fishFarm
    case waterworksSite
    case park
    case sportsSite
    case recreationArea
    case religiousSite
    case historicSite
    case cemetery
    case miscellaneousLand

    // MARK: 건물/시설
    case building
    case residentialBuilding
    case detachedHouse
    case multiHousehold
    case multipleOccupancy
    case apartment
    case rowHouse
    case multiFamilyHousing
    case dormitory
    case villa
    case shopHouse
    case officetel
    case mixedUseResidentialCommercial
    case commercialAndOffice
    case neighborhoodFacility
    case culturalAssemblyFacility
    case religiousFacility
    case retailFacility
    case transportationFacility
    case medicalFacility
    case educationResearchFacility
    case welfareFacility
    case trainingFacility
    case sportsFacility
    case officeFacility
    case lodgingFacility
    case entertainmentFacility
    case correctionalAndMilitaryFacility
    case broadcastingTelecomFacility
    case powerGenerationFacility
    case cemeteryRelatedFacility
    case tourismRestFacility
    case industrialAndSpecialPurpose
    case factory
    case warehouseFacility
    case hazmatFacility
    case automotiveFacility
    case animalPlantFacility
    case wasteTreatmentFacility
    case mixedUse
    case residentialCommercialBuilding
    case residentialIndustrialBuilding
    case otherMixedUseBuilding

    /// 미매핑 (배치 수집 대상 외 카테고리 또는 신규 코드)
    case other(String)

    public init(rawValue: String) {
      switch rawValue {
      // 토지/지목
      case "LAND": self = .land
      case "LAND_DESIGNATION": self = .landDesignation
      case "FIELD": self = .field
      case "PADDY": self = .paddy
      case "ORCHARD": self = .orchard
      case "RANCH_LAND": self = .ranchLand
      case "FOREST_LAND": self = .forestLand
      case "MINERAL_SPRING_LAND": self = .mineralSpringLand
      case "SALT_PAN": self = .saltPan
      case "BUILDING_SITE": self = .buildingSite
      case "FACTORY_SITE": self = .factorySite
      case "SCHOOL_SITE": self = .schoolSite
      case "PARKING_LOT": self = .parkingLot
      case "GAS_STATION_SITE": self = .gasStationSite
      case "WAREHOUSE_SITE": self = .warehouseSite
      case "ROAD": self = .road
      case "RAILWAY_SITE": self = .railwaySite
      case "EMBANKMENT": self = .embankment
      case "RIVER": self = .river
      case "DITCH": self = .ditch
      case "RESERVOIR": self = .reservoir
      case "FISH_FARM": self = .fishFarm
      case "WATERWORKS_SITE": self = .waterworksSite
      case "PARK": self = .park
      case "SPORTS_SITE": self = .sportsSite
      case "RECREATION_AREA": self = .recreationArea
      case "RELIGIOUS_SITE": self = .religiousSite
      case "HISTORIC_SITE": self = .historicSite
      case "CEMETERY": self = .cemetery
      case "MISCELLANEOUS_LAND": self = .miscellaneousLand
      // 건물/시설
      case "BUILDING": self = .building
      case "RESIDENTIAL_BUILDING": self = .residentialBuilding
      case "DETACHED_HOUSE": self = .detachedHouse
      case "MULTI_HOUSEHOLD": self = .multiHousehold
      case "MULTIPLE_OCCUPANCY": self = .multipleOccupancy
      case "APARTMENT": self = .apartment
      case "ROW_HOUSE": self = .rowHouse
      case "MULTI_FAMILY_HOUSING": self = .multiFamilyHousing
      case "DORMITORY": self = .dormitory
      case "VILLA": self = .villa
      case "SHOP_HOUSE": self = .shopHouse
      case "OFFICETEL": self = .officetel
      case "MIXED_USE_RESIDENTIAL_COMMERCIAL": self = .mixedUseResidentialCommercial
      case "COMMERCIAL_AND_OFFICE": self = .commercialAndOffice
      case "NEIGHBORHOOD_FACILITY": self = .neighborhoodFacility
      case "CULTURAL_ASSEMBLY_FACILITY": self = .culturalAssemblyFacility
      case "RELIGIOUS_FACILITY": self = .religiousFacility
      case "RETAIL_FACILITY": self = .retailFacility
      case "TRANSPORTATION_FACILITY": self = .transportationFacility
      case "MEDICAL_FACILITY": self = .medicalFacility
      case "EDUCATION_RESEARCH_FACILITY": self = .educationResearchFacility
      case "WELFARE_FACILITY": self = .welfareFacility
      case "TRAINING_FACILITY": self = .trainingFacility
      case "SPORTS_FACILITY": self = .sportsFacility
      case "OFFICE_FACILITY": self = .officeFacility
      case "LODGING_FACILITY": self = .lodgingFacility
      case "ENTERTAINMENT_FACILITY": self = .entertainmentFacility
      case "CORRECTIONAL_AND_MILITARY_FACILITY": self = .correctionalAndMilitaryFacility
      case "BROADCASTING_TELECOM_FACILITY": self = .broadcastingTelecomFacility
      case "POWER_GENERATION_FACILITY": self = .powerGenerationFacility
      case "CEMETERY_RELATED_FACILITY": self = .cemeteryRelatedFacility
      case "TOURISM_REST_FACILITY": self = .tourismRestFacility
      case "INDUSTRIAL_AND_SPECIAL_PURPOSE": self = .industrialAndSpecialPurpose
      case "FACTORY": self = .factory
      case "WAREHOUSE_FACILITY": self = .warehouseFacility
      case "HAZMAT_FACILITY": self = .hazmatFacility
      case "AUTOMOTIVE_FACILITY": self = .automotiveFacility
      case "ANIMAL_PLANT_FACILITY": self = .animalPlantFacility
      case "WASTE_TREATMENT_FACILITY": self = .wasteTreatmentFacility
      case "MIXED_USE": self = .mixedUse
      case "RESIDENTIAL_COMMERCIAL_BUILDING": self = .residentialCommercialBuilding
      case "RESIDENTIAL_INDUSTRIAL_BUILDING": self = .residentialIndustrialBuilding
      case "OTHER_MIXED_USE_BUILDING": self = .otherMixedUseBuilding
      default: self = .other(rawValue)
      }
    }
  }

  /// 입찰 방식
  public enum BidType: Sendable {
    /// 기일입찰
    case scheduledBid
    /// 기간입찰
    case periodBid
    /// 호가입찰
    case askingBid
    /// 매핑 실패 (비노출 권장)
    case invalid
    /// 신규/미매핑 코드
    case other(String)

    public init(rawValue: String) {
      switch rawValue {
      case "SCHEDULED_BID": self = .scheduledBid
      case "PERIOD_BID": self = .periodBid
      case "ASKING_BID": self = .askingBid
      case "INVALID", "": self = .invalid
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
      /// 매각준비
      case preparingSale
      /// 매각
      case sold
      /// 유찰
      case failedBid
      /// 최고가매각허가결정
      case bestBidApproved
      /// 차순위매각허가결정
      case secondaryBidApproved
      /// 최고가매각불허가결정
      case bestBidRejected
      /// 차순위매각불허가결정
      case secondaryBidRejected
      /// 기한변경
      case deadlineChanged
      /// 추후지정
      case toBeSpecified
      /// 납부
      case paymentCompleted
      /// 미납
      case paymentMissed
      /// 기한후납부
      case latePayment
      /// 상계허가
      case offsetApproved
      /// 진행
      case inProgress
      /// 변경
      case modified
      /// 배당종결
      case distributionCompleted
      /// 배당불가
      case distributionUnavailable
      /// 최고가매각허가취소결정
      case bestBidApprovalCancelled
      /// 차순위매각허가취소결정
      case secondaryBidApprovalCancelled
      /// 매핑 실패 (비노출 권장)
      case invalid
      /// 신규/미매핑 코드
      case other(String)

      public init(rawValue: String) {
        switch rawValue {
        case "PREPARING_SALE": self = .preparingSale
        case "SOLD": self = .sold
        case "FAILED": self = .failedBid
        case "BEST_BID_APPROVED": self = .bestBidApproved
        case "SECONDARY_BID_APPROVED": self = .secondaryBidApproved
        case "BEST_BID_REJECTED": self = .bestBidRejected
        case "SECONDARY_BID_REJECTED": self = .secondaryBidRejected
        case "DEADLINE_CHANGED": self = .deadlineChanged
        case "TO_BE_SPECIFIED": self = .toBeSpecified
        case "PAYMENT_COMPLETED": self = .paymentCompleted
        case "PAYMENT_MISSED": self = .paymentMissed
        case "LATE_PAYMENT": self = .latePayment
        case "OFFSET_APPROVED": self = .offsetApproved
        case "IN_PROGRESS": self = .inProgress
        case "MODIFIED": self = .modified
        case "DISTRIBUTION_COMPLETED": self = .distributionCompleted
        case "DISTRIBUTION_UNAVAILABLE": self = .distributionUnavailable
        case "BEST_BID_APPROVAL_CANCELLED": self = .bestBidApprovalCancelled
        case "SECONDARY_BID_APPROVAL_CANCELLED": self = .secondaryBidApprovalCancelled
        case "INVALID", "": self = .invalid
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
      /// 집합건물
      case collectiveBuilding
      /// 토지,건물
      case landAndBuilding
      /// 기타
      case etc
      /// 매핑 실패 (비노출 권장)
      case invalid
      /// 신규/미매핑 코드
      case other(String)

      public init(rawValue: String) {
        switch rawValue {
        case "LAND": self = .land
        case "BUILDING": self = .building
        case "COLLECTIVE_BUILDING": self = .collectiveBuilding
        case "LAND_AND_BUILDING": self = .landAndBuilding
        case "OTHER": self = .etc
        case "INVALID", "": self = .invalid
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
