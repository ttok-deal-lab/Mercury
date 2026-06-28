//
//  SampleMapView.swift
//  AuctionDetailSampleApp
//
//  실제 지도(Kakao) 모듈 대신 좌표만 보여주는 미리보기용 MapViewable.
//

import SwiftUI

import Router

struct SampleMapView: View, MapViewable {
  let targetLongitude: Double
  let targetLatitude: Double

  init(targetLongitude: Double, targetLatitude: Double) {
    self.targetLongitude = targetLongitude
    self.targetLatitude = targetLatitude
  }

  var body: some View {
    ZStack {
      Rectangle()
        .fill(Color.gray.opacity(0.15))

      VStack(spacing: 6) {
        Image(systemName: "map")
          .font(.system(size: 28))
        Text("지도 영역 (Sample)")
          .font(.system(size: 13, weight: .semibold))
        Text(String(format: "%.4f, %.4f", targetLatitude, targetLongitude))
          .font(.system(size: 11))
      }
      .foregroundStyle(.secondary)
    }
  }
}
