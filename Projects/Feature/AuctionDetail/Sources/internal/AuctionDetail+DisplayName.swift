//
//  AuctionDetail+DisplayName.swift
//  AuctionDetail
//
//  Created by DevLifter on 4/18/26.
//

import Foundation

import Domain

extension AuctionDetail {
  /// 경매구분(사건명) 노출 값.
  /// 단순 부동산 매매 성격의 강제/임의경매만 노출하고,
  /// 공유물분할·형식적경매·유치권경매·선박경매 등은 비노출("-") 처리한다.
  var displayCaseName: String {
    switch caseName {
    case "부동산강제경매", "부동산임의경매":
      return caseName
    default:
      return "-"
    }
  }
}

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
  /// 기일종류 툴팁 설명. 매핑이 없는 케이스(invalid/other)는 nil.
  var infoDescription: String? {
    switch self {
    // 기일 진행
    case .planned: return "경매 기일이 잡혀 입찰이 예정된 상태"
    case .preparingSale: return "매각을 위한 사전 절차가 진행 중인 상태"
    case .inProgress: return "경매 기일에 입찰이 진행 중이거나 예정된 상태"
    case .failedBid: return "입찰자가 없어 낙찰되지 않고 다음 기일로 넘어가는 상태"
    case .sold: return "입찰 경쟁을 통해 낙찰자가 결정되어 매각이 완료된 상태 (매수인 및 낙찰가 포함)"
    // 매각 허가 / 불허가
    case .bestBidApproved: return "법원이 매각허가결정을 내려 소유권 이전 절차가 진행되는 상태"
    case .secondaryBidApproved: return "법원이 차순위 매수신고인에게 매각허가결정을 내린 상태"
    case .bestBidRejected: return "이의제기 등으로 법원이 매각허가를 불허한 상태"
    case .secondaryBidRejected: return "이의제기 등으로 법원이 차순위 매수신고인에 대한 매각허가를 불허한 상태"
    case .bestBidApprovalCancelled: return "법원이 최고가 매수인에 대한 매각허가결정을 취소한 상태"
    case .secondaryBidApprovalCancelled: return "법원이 차순위 매수신고인에 대한 매각허가결정을 취소한 상태"
    // 대금 납부
    case .paymentCompleted: return "매수인이 정해진 기한 내 매각대금을 완납한 상태"
    case .paymentMissed: return "매수인이 기한 내 매각대금을 납부하지 않은 상태"
    case .latePayment: return "매수인이 지정된 기한 이후 매각대금을 납부한 상태"
    case .offsetApproved: return "채권자인 매수인이 배당받을 금액과 매각대금의 상계를 법원이 허가한 상태"
    // 일정 변경
    case .modified: return "법원 사정 등으로 경매 일정(기일)이 변경된 상태"
    case .deadlineChanged: return "법원 사정 등으로 대금 납부 등 기한이 변경된 상태"
    case .toBeSpecified: return "다음 기일이 아직 정해지지 않아 추후 지정될 예정인 상태"
    // 배당 / 종결
    case .distributionCompleted: return "매각대금이 채권자에게 배당되어 경매절차가 종결된 상태"
    case .distributionUnavailable: return "배당 요건을 충족하지 못해 배당을 진행할 수 없는 상태"
    case .invalid, .other:
      return nil
    }
  }

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
