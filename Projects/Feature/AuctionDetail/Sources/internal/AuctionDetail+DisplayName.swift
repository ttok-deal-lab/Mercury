//
//  AuctionDetail+DisplayName.swift
//  AuctionDetail
//
//  Created by DevLifter on 4/18/26.
//

import Foundation

import Domain

extension AuctionDetail.ItemType {
  var displayName: String {
    switch self {
    case .apartment: return "아파트"
    case .detachedHouse: return "단독주택"
    case .multiHousehold: return "다가구주택"
    case .rowHouse: return "연립주택"
    case .multiFamily: return "다세대"
    case .villa: return "빌라"
    case .automobile: return "자동차"
    case .heavyEquipment: return "중기"
    case .land: return "대지"
    case .forest: return "임야"
    case .farmland: return "전답"
    case .commercial: return "상가"
    case .officeTel: return "오피스텔"
    case .neighborhoodFacility: return "근린시설"
    case .other: return "기타"
    }
  }
}

extension AuctionDetail.SalesCategory {
  var displayName: String {
    switch self {
    // 토지/지목
    case .land: return "토지"
    case .landDesignation: return "지목"
    case .field: return "전"
    case .paddy: return "답"
    case .orchard: return "과수원"
    case .ranchLand: return "목장용지"
    case .forestLand: return "임야"
    case .mineralSpringLand: return "광천지"
    case .saltPan: return "염전"
    case .buildingSite: return "대지"
    case .factorySite: return "공장용지"
    case .schoolSite: return "학교용지"
    case .parkingLot: return "주차장"
    case .gasStationSite: return "주유소용지"
    case .warehouseSite: return "창고용지"
    case .road: return "도로"
    case .railwaySite: return "철도용지"
    case .embankment: return "제방"
    case .river: return "하천"
    case .ditch: return "구거"
    case .reservoir: return "유지"
    case .fishFarm: return "양어장"
    case .waterworksSite: return "수도용지"
    case .park: return "공원"
    case .sportsSite: return "체육용지"
    case .recreationArea: return "유원지"
    case .religiousSite: return "종교용지"
    case .historicSite: return "사적지"
    case .cemetery: return "묘지"
    case .miscellaneousLand: return "잡종지"
    // 건물/시설
    case .building: return "건물"
    case .residentialBuilding: return "주거용건물"
    case .detachedHouse: return "단독주택"
    case .multiHousehold: return "다가구주택"
    case .multipleOccupancy: return "다중주택"
    case .apartment: return "아파트"
    case .rowHouse: return "연립주택"
    case .multiFamilyHousing: return "다세대주택"
    case .dormitory: return "기숙사"
    case .villa: return "빌라"
    case .shopHouse: return "상가주택"
    case .officetel: return "오피스텔"
    case .mixedUseResidentialCommercial: return "주상복합"
    case .commercialAndOffice: return "상업용및업무용"
    case .neighborhoodFacility: return "근린생활시설"
    case .culturalAssemblyFacility: return "문화및집회시설"
    case .religiousFacility: return "종교시설"
    case .retailFacility: return "판매시설"
    case .transportationFacility: return "운수시설"
    case .medicalFacility: return "의료시설"
    case .educationResearchFacility: return "교육연구시설"
    case .welfareFacility: return "노유자시설"
    case .trainingFacility: return "수련시설"
    case .sportsFacility: return "운동시설"
    case .officeFacility: return "업무시설"
    case .lodgingFacility: return "숙박시설"
    case .entertainmentFacility: return "위락시설"
    case .correctionalAndMilitaryFacility: return "교정및군사시설"
    case .broadcastingTelecomFacility: return "방송통신시설"
    case .powerGenerationFacility: return "발전시설"
    case .cemeteryRelatedFacility: return "묘지관련시설"
    case .tourismRestFacility: return "관광휴게시설"
    case .industrialAndSpecialPurpose: return "산업용및기타특수용"
    case .factory: return "공장"
    case .warehouseFacility: return "창고시설"
    case .hazmatFacility: return "위험물저장및처리시설"
    case .automotiveFacility: return "자동차관련시설"
    case .animalPlantFacility: return "동물및식물관련시설"
    case .wasteTreatmentFacility: return "분뇨및쓰레기처리시설"
    case .mixedUse: return "용도복합용"
    case .residentialCommercialBuilding: return "주/상용건물"
    case .residentialIndustrialBuilding: return "주/산용건물"
    case .otherMixedUseBuilding: return "기타복합용건물"
    // 수집 대상 외 카테고리는 비노출
    case .other: return ""
    }
  }
}

extension AuctionDetail.BidType {
  var displayName: String {
    switch self {
    case .scheduledBid: return "기일입찰"
    case .periodBid: return "기간입찰"
    case .askingBid: return "호가입찰"
    case .invalid: return ""
    case .other(let value): return value
    }
  }
}

extension AuctionDetail.SalesDetail.SalesResult {
  var displayName: String {
    switch self {
    case .planned: return "예정"
    case .preparingSale: return "매각준비"
    case .sold: return "매각"
    case .failedBid: return "유찰"
    case .bestBidApproved: return "최고가매각허가결정"
    case .secondaryBidApproved: return "차순위매각허가결정"
    case .bestBidRejected: return "최고가매각불허가결정"
    case .secondaryBidRejected: return "차순위매각불허가결정"
    case .deadlineChanged: return "기한변경"
    case .toBeSpecified: return "추후지정"
    case .paymentCompleted: return "납부"
    case .paymentMissed: return "미납"
    case .latePayment: return "기한후납부"
    case .offsetApproved: return "상계허가"
    case .inProgress: return "진행"
    case .modified: return "변경"
    case .distributionCompleted: return "배당종결"
    case .distributionUnavailable: return "배당불가"
    case .bestBidApprovalCancelled: return "최고가매각허가취소결정"
    case .secondaryBidApprovalCancelled: return "차순위매각허가취소결정"
    case .invalid: return ""
    case .other(let value): return value
    }
  }
}

extension AuctionDetail.SalesItemDetail.ItemDetailType {
  var displayName: String {
    switch self {
    case .land: return "토지"
    case .building: return "건물"
    case .collectiveBuilding: return "집합건물"
    case .landAndBuilding: return "토지,건물"
    case .etc: return "기타"
    case .invalid: return ""
    case .other(let value): return value
    }
  }
}
