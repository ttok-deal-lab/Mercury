//
//  CrewLeaderApplyDetailModelData.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import Foundation

import AppFoundation

@Observable
final class CrewLeaderApplyDetailModelData {
  // MARK: - internal property
  var profileImageData: Data?
  var reportFileURL: URL?
  var introduction: String = ""
  var links: [CrewLeaderLinkInput] = [CrewLeaderLinkInput()]
  var contact: String = ""
  var career: String = ""
  var isLoading: Bool = false
  var error: Error?
  
  /// 디자인상 필수(*) 항목: 프로필 이미지 · 링크 1개 이상 · 연락처
  var isSubmittable: Bool {
    profileImageData != nil
      && links.contains { !$0.url.trimmingCharacters(in: .whitespaces).isEmpty }
      && !contact.trimmingCharacters(in: .whitespaces).isEmpty
  }
  
  // MARK: - life cycle
  init() { }
  
  // MARK: - internal method
  func addLink() {
    links.append(CrewLeaderLinkInput())
  }
  
  /// 신청 성공 여부. API 가 확정되면 UseCase 호출 결과로 교체한다. 지금은 화면 흐름 확인을 위해 항상 성공.
  func submit() async -> Bool {
    isLoading = true
    defer { isLoading = false }
    return true
  }
}
