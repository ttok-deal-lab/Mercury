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
  /// 법원 상세 정보 (서버 court 객체)
  public let courtInfo: CourtInfo
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
  /// 인증 매물 여부
  public let verified: Bool
  /// 건물명
  public let salesBuildingName: String
  /// 전용면적 (㎡)
  public let exclusiveArea: Double
  /// 사건명
  public let caseName: String
  /// 채권자 수
  public let creditorCount: Int
  /// 최근 실거래가 (데이터 없으면 nil)
  public let recentTransactionPrice: Int?
  /// 최근 실거래일 (데이터 없으면 nil)
  public let recentTransactionDate: Date?
  /// 권리분석 목록
  public let rightsAnalysis: [RightsAnalysis]

  public init(
    id: Int,
    salesNumber: String,
    itemTypes: [ItemType],
    appraisalPrice: Int,
    lowestSalesPrice: Int,
    bidType: BidType,
    salesDateTime: Date,
    salesLocation: String,
    salesNote: String,
    salesReceptionDate: Date,
    salesOpenDate: Date,
    distributionRequiredDeadlineDate: Date,
    salesAddress: String,
    salesCategories: [SalesCategory],
    failBidCount: Int,
    zzimCount: Int,
    court: Court,
    courtInfo: CourtInfo,
    salesDetails: [SalesDetail],
    salesPictures: [SalesPicture],
    salesBuildings: [SalesBuilding],
    salesItemDetails: [SalesItemDetail],
    conditionReport: ConditionReport,
    appraisalDocumentUrl: URL?,
    appraisalDocuments: [AppraisalDocument],
    nearbySalesStats: [NearbySalesStat],
    soldOut: Bool,
    verified: Bool,
    salesBuildingName: String,
    exclusiveArea: Double,
    caseName: String,
    creditorCount: Int,
    recentTransactionPrice: Int?,
    recentTransactionDate: Date?,
    rightsAnalysis: [RightsAnalysis]
  ) {
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
    self.courtInfo = courtInfo
    self.salesDetails = salesDetails
    self.salesPictures = salesPictures
    self.salesBuildings = salesBuildings
    self.salesItemDetails = salesItemDetails
    self.conditionReport = conditionReport
    self.appraisalDocumentUrl = appraisalDocumentUrl
    self.appraisalDocuments = appraisalDocuments
    self.nearbySalesStats = nearbySalesStats
    self.soldOut = soldOut
    self.verified = verified
    self.salesBuildingName = salesBuildingName
    self.exclusiveArea = exclusiveArea
    self.caseName = caseName
    self.creditorCount = creditorCount
    self.recentTransactionPrice = recentTransactionPrice
    self.recentTransactionDate = recentTransactionDate
    self.rightsAnalysis = rightsAnalysis
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
  
  /// 법원 상세 정보 (서버 court 객체)
  public struct CourtInfo: Sendable {
    /// 법원 코드
    public let code: String
    /// 법원명 (서버 코드값)
    public let name: String
    /// 법원 주소
    public let address: String
    /// 위도 (서버 미제공 시 nil)
    public let latitude: Double?
    /// 경도 (서버 미제공 시 nil)
    public let longitude: Double?

    public init(code: String, name: String, address: String, latitude: Double? = nil, longitude: Double? = nil) {
      self.code = code
      self.name = name
      self.address = address
      self.latitude = latitude
      self.longitude = longitude
    }

    /// 한글 법원명 (서버 enum → 한글 라벨 변환)
    public var displayName: String {
      CourtName(rawValue: name).displayName
    }

    /// 서버 `court.name` enum (CourtName) 매핑
    /// - 원본: sherbet-api `CourtItemFeignModels.kt` `CourtName`
    public enum CourtName: Sendable {
      // 서울권
      case seoulCentralDistrict        // 서울중앙지방법원
      case seoulEastDistrict           // 서울동부지방법원
      case seoulWestDistrict           // 서울서부지방법원
      case seoulSouthDistrict          // 서울남부지방법원
      case seoulNorthDistrict          // 서울북부지방법원

      // 경기·인천권
      case uijeongbuDistrict           // 의정부지방법원
      case goyangBranch                // 고양지원
      case namyangjuBranch             // 남양주지원
      case incheonDistrict             // 인천지방법원
      case bucheonBranch               // 부천지원
      case suwonDistrict               // 수원지방법원
      case seongnamBranch              // 성남지원
      case yeojuBranch                 // 여주지원
      case pyeongtaekBranch            // 평택지원
      case ansanBranch                 // 안산지원
      case anyangBranch                // 안양지원

      // 강원권
      case chuncheonDistrict           // 춘천지방법원
      case gangneungBranch             // 강릉지원
      case wonjuBranch                 // 원주지원
      case sokchoBranch                // 속초지원
      case yeongwolBranch              // 영월지원

      // 충청권
      case cheongjuDistrict            // 청주지방법원
      case chungjuBranch               // 충주지원
      case jecheonBranch               // 제천지원
      case yeongdongBranch             // 영동지원
      case daejeonDistrict             // 대전지방법원
      case hongseongBranch             // 홍성지원
      case nonsanBranch                // 논산지원
      case cheonanBranch               // 천안지원
      case gongjuBranch                // 공주지원
      case seosanBranch                // 서산지원

      // 경상권 (대구·경북)
      case daeguDistrict               // 대구지방법원
      case andongBranch                // 안동지원
      case gyeongjuBranch              // 경주지원
      case gimcheonBranch              // 김천지원
      case sangjuBranch                // 상주지원
      case uiseongBranch               // 의성지원
      case yeongdeokBranch             // 영덕지원
      case pohangBranch                // 포항지원
      case daeguWestBranch             // 대구서부지원

      // 경상권 (부산·울산·경남)
      case busanDistrict               // 부산지방법원
      case busanEastBranch             // 부산동부지원
      case busanWestBranch             // 부산서부지원
      case ulsanDistrict               // 울산지방법원
      case changwonDistrict            // 창원지방법원
      case masanBranch                 // 마산지원
      case jinjuBranch                 // 진주지원
      case tongyeongBranch             // 통영지원
      case milyangBranch               // 밀양지원
      case geochangBranch              // 거창지원

      // 전라권
      case gwangjuDistrict             // 광주지방법원
      case mokpoBranch                 // 목포지원
      case jangheungBranch             // 장흥지원
      case suncheonBranch              // 순천지원
      case haenamBranch                // 해남지원
      case jeonjuDistrict              // 전주지방법원
      case gunsanBranch                // 군산지원
      case jeongeupBranch              // 정읍지원
      case namwonBranch                // 남원지원

      // 제주
      case jejuDistrict                // 제주지방법원

      // Fallback
      case invalid                     // 매핑 실패
      case other(String)               // 알 수 없는 값 (서버 신규 enum 대비)

      public init(rawValue: String) {
        switch rawValue {
        // 서울권
        case "SEOUL_CENTRAL_DISTRICT": self = .seoulCentralDistrict
        case "SEOUL_EAST_DISTRICT":    self = .seoulEastDistrict
        case "SEOUL_WEST_DISTRICT":    self = .seoulWestDistrict
        case "SEOUL_SOUTH_DISTRICT":   self = .seoulSouthDistrict
        case "SEOUL_NORTH_DISTRICT":   self = .seoulNorthDistrict

        // 경기·인천권
        case "UIJEONGBU_DISTRICT":     self = .uijeongbuDistrict
        case "GOYANG_BRANCH":          self = .goyangBranch
        case "NAMYANGJU_BRANCH":       self = .namyangjuBranch
        case "INCHEON_DISTRICT":       self = .incheonDistrict
        case "BUCHEON_BRANCH":         self = .bucheonBranch
        case "SUWON_DISTRICT":         self = .suwonDistrict
        case "SEONGNAM_BRANCH":        self = .seongnamBranch
        case "YEOJU_BRANCH":           self = .yeojuBranch
        case "PYEONGTAEK_BRANCH":      self = .pyeongtaekBranch
        case "ANSAN_BRANCH":           self = .ansanBranch
        case "ANYANG_BRANCH":          self = .anyangBranch

        // 강원권
        case "CHUNCHEON_DISTRICT":     self = .chuncheonDistrict
        case "GANGNEUNG_BRANCH":       self = .gangneungBranch
        case "WONJU_BRANCH":           self = .wonjuBranch
        case "SOKCHO_BRANCH":          self = .sokchoBranch
        case "YEONGWOL_BRANCH":        self = .yeongwolBranch

        // 충청권
        case "CHEONGJU_DISTRICT":      self = .cheongjuDistrict
        case "CHUNGJU_BRANCH":         self = .chungjuBranch
        case "JECHEON_BRANCH":         self = .jecheonBranch
        case "YEONGDONG_BRANCH":       self = .yeongdongBranch
        case "DAEJEON_DISTRICT":       self = .daejeonDistrict
        case "HONGSEONG_BRANCH":       self = .hongseongBranch
        case "NONSAN_BRANCH":          self = .nonsanBranch
        case "CHEONAN_BRANCH":         self = .cheonanBranch
        case "GONGJU_BRANCH":          self = .gongjuBranch
        case "SEOSAN_BRANCH":          self = .seosanBranch

        // 경상권 (대구·경북)
        case "DAEGU_DISTRICT":         self = .daeguDistrict
        case "ANDONG_BRANCH":          self = .andongBranch
        case "GYEONGJU_BRANCH":        self = .gyeongjuBranch
        case "GIMCHEON_BRANCH":        self = .gimcheonBranch
        case "SANGJU_BRANCH":          self = .sangjuBranch
        case "UISEONG_BRANCH":         self = .uiseongBranch
        case "YEONGDEOK_BRANCH":       self = .yeongdeokBranch
        case "POHANG_BRANCH":          self = .pohangBranch
        case "DAEGU_WEST_BRANCH":      self = .daeguWestBranch

        // 경상권 (부산·울산·경남)
        case "BUSAN_DISTRICT":         self = .busanDistrict
        case "BUSAN_EAST_BRANCH":      self = .busanEastBranch
        case "BUSAN_WEST_BRANCH":      self = .busanWestBranch
        case "ULSAN_DISTRICT":         self = .ulsanDistrict
        case "CHANGWON_DISTRICT":      self = .changwonDistrict
        case "MASAN_BRANCH":           self = .masanBranch
        case "JINJU_BRANCH":           self = .jinjuBranch
        case "TONGYEONG_BRANCH":       self = .tongyeongBranch
        case "MILYANG_BRANCH":         self = .milyangBranch
        case "GEOCHANG_BRANCH":        self = .geochangBranch

        // 전라권
        case "GWANGJU_DISTRICT":       self = .gwangjuDistrict
        case "MOKPO_BRANCH":           self = .mokpoBranch
        case "JANGHEUNG_BRANCH":       self = .jangheungBranch
        case "SUNCHEON_BRANCH":        self = .suncheonBranch
        case "HAENAM_BRANCH":          self = .haenamBranch
        case "JEONJU_DISTRICT":        self = .jeonjuDistrict
        case "GUNSAN_BRANCH":          self = .gunsanBranch
        case "JEONGEUP_BRANCH":        self = .jeongeupBranch
        case "NAMWON_BRANCH":          self = .namwonBranch

        // 제주
        case "JEJU_DISTRICT":          self = .jejuDistrict

        // Fallback
        case "INVALID", "":            self = .invalid
        default:                       self = .other(rawValue)
        }
      }

      public var displayName: String {
        switch self {
        // 서울권
        case .seoulCentralDistrict: return "서울중앙지방법원"
        case .seoulEastDistrict:    return "서울동부지방법원"
        case .seoulWestDistrict:    return "서울서부지방법원"
        case .seoulSouthDistrict:   return "서울남부지방법원"
        case .seoulNorthDistrict:   return "서울북부지방법원"

        // 경기·인천권
        case .uijeongbuDistrict:    return "의정부지방법원"
        case .goyangBranch:         return "고양지원"
        case .namyangjuBranch:      return "남양주지원"
        case .incheonDistrict:      return "인천지방법원"
        case .bucheonBranch:        return "부천지원"
        case .suwonDistrict:        return "수원지방법원"
        case .seongnamBranch:       return "성남지원"
        case .yeojuBranch:          return "여주지원"
        case .pyeongtaekBranch:     return "평택지원"
        case .ansanBranch:          return "안산지원"
        case .anyangBranch:         return "안양지원"

        // 강원권
        case .chuncheonDistrict:    return "춘천지방법원"
        case .gangneungBranch:      return "강릉지원"
        case .wonjuBranch:          return "원주지원"
        case .sokchoBranch:         return "속초지원"
        case .yeongwolBranch:       return "영월지원"

        // 충청권
        case .cheongjuDistrict:     return "청주지방법원"
        case .chungjuBranch:        return "충주지원"
        case .jecheonBranch:        return "제천지원"
        case .yeongdongBranch:      return "영동지원"
        case .daejeonDistrict:      return "대전지방법원"
        case .hongseongBranch:      return "홍성지원"
        case .nonsanBranch:         return "논산지원"
        case .cheonanBranch:        return "천안지원"
        case .gongjuBranch:         return "공주지원"
        case .seosanBranch:         return "서산지원"

        // 경상권 (대구·경북)
        case .daeguDistrict:        return "대구지방법원"
        case .andongBranch:         return "안동지원"
        case .gyeongjuBranch:       return "경주지원"
        case .gimcheonBranch:       return "김천지원"
        case .sangjuBranch:         return "상주지원"
        case .uiseongBranch:        return "의성지원"
        case .yeongdeokBranch:      return "영덕지원"
        case .pohangBranch:         return "포항지원"
        case .daeguWestBranch:      return "대구서부지원"

        // 경상권 (부산·울산·경남)
        case .busanDistrict:        return "부산지방법원"
        case .busanEastBranch:      return "부산동부지원"
        case .busanWestBranch:      return "부산서부지원"
        case .ulsanDistrict:        return "울산지방법원"
        case .changwonDistrict:     return "창원지방법원"
        case .masanBranch:          return "마산지원"
        case .jinjuBranch:          return "진주지원"
        case .tongyeongBranch:      return "통영지원"
        case .milyangBranch:        return "밀양지원"
        case .geochangBranch:       return "거창지원"

        // 전라권
        case .gwangjuDistrict:      return "광주지방법원"
        case .mokpoBranch:          return "목포지원"
        case .jangheungBranch:      return "장흥지원"
        case .suncheonBranch:       return "순천지원"
        case .haenamBranch:         return "해남지원"
        case .jeonjuDistrict:       return "전주지방법원"
        case .gunsanBranch:         return "군산지원"
        case .jeongeupBranch:       return "정읍지원"
        case .namwonBranch:         return "남원지원"

        // 제주
        case .jejuDistrict:         return "제주지방법원"

        // Fallback (스펙: INVALID → 빈 문자열, 알 수 없는 값은 원본 노출)
        case .invalid:              return ""
        case .other(let raw):       return raw
        }
      }
    }
  }

  /// 경매 상세 기일 정보
  public struct SalesDetail: Sendable {
    /// 기일. 서버 값이 파싱 불가한 형식이면 nil (가짜 날짜로 대체하지 않는다)
    public let timeStamp: Date?
    /// 기일 종류
    public let type: SalesDetailType
    /// 기일 장소
    public let location: String
    /// 최저 낙찰가. 최고가매각불허가결정 등 최저가가 없는 기일은 서버가 null 을 내려준다.
    public let leastSalesPrice: Int?
    /// 기일 결과
    public let result: SalesResult

    public init(timeStamp: Date?, type: SalesDetailType, location: String, leastSalesPrice: Int?, result: SalesResult) {
      self.timeStamp = timeStamp
      self.type = type
      self.location = location
      self.leastSalesPrice = leastSalesPrice
      self.result = result
    }
    
    /// 서버 `salesDetails[].type` enum (AuctionDetailType) 매핑
    /// - 원본: sherbet-common `CourtItemFeignModels.kt:140` `AuctionDetailType`
    public enum SalesDetailType: Sendable {
      /// 매각기일
      case sale
      /// 매각결정기일
      case saleDecision
      /// 신규/미매핑 코드
      case other(String)

      public init(rawValue: String) {
        switch rawValue {
        case "SALE":          self = .sale
        case "SALE_DECISION": self = .saleDecision
        default:              self = .other(rawValue)
        }
      }

      public var displayName: String {
        switch self {
        case .sale:                return "매각기일"
        case .saleDecision:        return "매각결정기일"
        case .other(let rawValue): return rawValue
        }
      }
    }
    
    /// 기일 결과
    public enum SalesResult: Sendable {
      /// 예정
      case planned
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

      /*
       | `PLANNED` | 예정 |
       | `PREPARING_SALE` | 매각준비 |
       | `IN_PROGRESS` | 진행 |
       | `FAILED` | 유찰 |
       | `SOLD` | 매각 |
       
       | `BEST_BID_APPROVED` | 최고가매각허가결정 |
       | `SECONDARY_BID_APPROVED` | 차순위매각허가결정 |
       | `BEST_BID_REJECTED` | 최고가매각불허가결정 |
       | `SECONDARY_BID_REJECTED` | 차순위매각불허가결정 |
       | `BEST_BID_APPROVAL_CANCELLED` | 최고가매각허가취소결정 |
       | `SECONDARY_BID_APPROVAL_CANCELLED` | 차순위매각허가취소결정 |
       
       | `PAYMENT_COMPLETED` | 납부 |
       | `PAYMENT_MISSED` | 미납 |
       | `LATE_PAYMENT` | 기한후납부 |
       | `OFFSET_APPROVED` | 상계허가 |
       
       | `MODIFIED` | 변경 |
       | `DEADLINE_CHANGED` | 기한변경 |
       | `TO_BE_SPECIFIED` | 추후지정 |
       
       | `DISTRIBUTION_COMPLETED` | 배당종결 |
       | `DISTRIBUTION_UNAVAILABLE` | 배당불가 |
       */
      
      /*
       
       [기일 진행]
       예정 : 경매 기일이 잡혀 입찰이 예정된 상태  🆕
       매각준비 : 매각을 위한 사전 절차가 진행 중인 상태  🆕
       진행 : 경매 기일에 입찰이 진행 중이거나 예정된 상태  ✅
       유찰 : 입찰자가 없어 낙찰되지 않고 다음 기일로 넘어가는 상태  ✅
       매각 : 입찰 경쟁을 통해 낙찰자가 결정되어 매각이 완료된 상태 (매수인 및 낙찰가 포함)  ✅

       [매각 허가 / 불허가]
       최고가매각허가결정 : 법원이 매각허가결정을 내려 소유권 이전 절차가 진행되는 상태  ✅(허가)
       차순위매각허가결정 : 법원이 차순위 매수신고인에게 매각허가결정을 내린 상태  🆕
       최고가매각불허가결정 : 이의제기 등으로 법원이 매각허가를 불허한 상태  ✅(불허가)
       차순위매각불허가결정 : 이의제기 등으로 법원이 차순위 매수신고인에 대한 매각허가를 불허한 상태  🆕
       최고가매각허가취소결정 : 법원이 최고가 매수인에 대한 매각허가결정을 취소한 상태  🆕
       차순위매각허가취소결정 : 법원이 차순위 매수신고인에 대한 매각허가결정을 취소한 상태  🆕

       [대금 납부]
       납부 : 매수인이 정해진 기한 내 매각대금을 완납한 상태  🆕
       미납 : 매수인이 기한 내 매각대금을 납부하지 않은 상태  🆕
       기한후납부 : 매수인이 지정된 기한 이후 매각대금을 납부한 상태  🆕
       상계허가 : 채권자인 매수인이 배당받을 금액과 매각대금의 상계를 법원이 허가한 상태  🆕

       [일정 변경]
       변경 : 법원 사정 등으로 경매 일정(기일)이 변경된 상태  ✅(변경/기일변경)
       기한변경 : 법원 사정 등으로 대금 납부 등 기한이 변경된 상태  🆕
       추후지정 : 다음 기일이 아직 정해지지 않아 추후 지정될 예정인 상태  🆕

       [배당 / 종결]
       배당종결 : 매각대금이 채권자에게 배당되어 경매절차가 종결된 상태  🆕(종료 변형)
       배당불가 : 배당 요건을 충족하지 못해 배당을 진행할 수 없는 상태  🆕
       */
      public init(rawValue: String) {
        switch rawValue {
        case "PLANNED": self = .planned
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
      
      // TODO: 말풍선 디스크립션 케이스 정리
//      public var description: String {
//        switch self {
//        case .inProgress:
//          return "경매 기일에 입찰이 진행 중이거나 예정된 상태"
//        case .modified:
//          return "법원 사정 등으로 경매 일정(기일)이 변경된 상태"
//        case .failedBid:
//          return "입찰자가 없어 낙찰되지 않고 다음 기일로 넘어가는 상태"
//        case .sold:
//          return "입찰 경쟁을 통해 낙찰자가 결정되어 매각이 완료된 상태 (매수인 및 낙찰가 포함)"
//        case .offsetApproved:
//          return "법원이 매각허가결정을 내려 소유권 이전 절차가 진행되는 상태"
//        case .
//        }
//      }
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
    /// 위도 (서버 미제공 시 nil)
    public let latitude: Double?
    /// 경도 (서버 미제공 시 nil)
    public let longitude: Double?

    public init(address: Address, detailAddress: String, category: BuildingCategory, latitude: Double? = nil, longitude: Double? = nil) {
      self.address = address
      self.detailAddress = detailAddress
      self.category = category
      self.latitude = latitude
      self.longitude = longitude
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
    /// 현황 조사일. 서버 값이 파싱 불가한 형식이면 nil
    public let investigationDate: Date?
    /// 부동산 임대차 정보
    public let estateLeaseInfos: [EstateLeaseInfo]
    /// 부동산 점유 관계
    public let occupationRelations: [OccupationRelation]
    /// 임대차 관계 조사서
    public let occupationRelationReports: [OccupationRelationReport]
    
    public init(investigationDate: Date?, estateLeaseInfos: [EstateLeaseInfo], occupationRelations: [OccupationRelation], occupationRelationReports: [OccupationRelationReport]) {
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
      /// 전입일자. 서버 값이 파싱 불가한 형식이면 nil
      public let movedAt: Date?
      /// 확정일자. 서버 값이 파싱 불가한 형식이면 nil
      public let confirmedAt: Date?
      
      public init(sequence: Int, address: String, occupant: String, relation: OccupantRelation, occupiedPart: String, purpose: OccupationPurpose, duration: String, deposit: Int, rental: Int, movedAt: Date?, confirmedAt: Date?) {
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

  /// 권리분석 (현재 서버 mock 데이터)
  public struct RightsAnalysis: Sendable {
    /// 이름
    public let name: String
    /// 구분 (임차인/채무자 등)
    public let role: String
    /// 대항력 여부
    public let hasOppositionRight: String
    /// 전입신고일
    public let moveInReportDate: String
    /// 점유 상태
    public let occupationStatus: String
    /// 우선변제권 여부
    public let priorityRepaymentRight: String
    /// 확정일자
    public let fixedDate: String
    /// 배당요구 여부
    public let dividendRequest: String
    /// 배당요구일
    public let dividendRequestDate: String
    /// 보증금
    public let deposit: Int
    /// 월세
    public let monthlyRent: Int

    public init(
      name: String,
      role: String,
      hasOppositionRight: String,
      moveInReportDate: String,
      occupationStatus: String,
      priorityRepaymentRight: String,
      fixedDate: String,
      dividendRequest: String,
      dividendRequestDate: String,
      deposit: Int,
      monthlyRent: Int
    ) {
      self.name = name
      self.role = role
      self.hasOppositionRight = hasOppositionRight
      self.moveInReportDate = moveInReportDate
      self.occupationStatus = occupationStatus
      self.priorityRepaymentRight = priorityRepaymentRight
      self.fixedDate = fixedDate
      self.dividendRequest = dividendRequest
      self.dividendRequestDate = dividendRequestDate
      self.deposit = deposit
      self.monthlyRent = monthlyRent
    }
  }
}
