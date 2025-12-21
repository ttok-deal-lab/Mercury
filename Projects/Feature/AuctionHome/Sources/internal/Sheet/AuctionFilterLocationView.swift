//
//  AuctionFilterLocationSheetView.swift
//  AuctionHome
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionFilterLocationView: View {
  @Binding var modelData: AuctionHomeModelData
  @State private var selectedRegion: Region?
  
  var region: [Region]? {
    modelData.auctionSearchFilter?.regions
  }
  
  var body: some View {
    ScrollView(.vertical) {
      VStack(alignment: .leading, spacing: .zero) {
        Text("지역 선택")
          .fonts(.titleLargeBold)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.top, 50)
          .padding(.bottom, 16)
          .padding(.horizontal, 20)
        
        Rectangle()
          .foregroundStyle(Asset.Colors.neutralLight.color)
          .frame(height: 1)
          .frame(maxWidth: .infinity)
        
        HStack(spacing: .zero) {
          RegionsSelectView(regions: region) {
            self.selectedRegion = $0
            modelData.filterRegion(region: $0)
          }
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.vertical, 16)
 
          if let selectedRegion {
            DistrictSelectView(districts: selectedRegion.districts) {
              modelData.filterDistrict(district: $0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
          }
        }
      }
    }
  }
}

struct RegionsSelectView: View {
  @State private var selected: Region?
  let regions: [Region]?
  var completion: (Region) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(regions ?? []) { region in
        Button {
          selected = region
          completion(region)
        } label: {
          HStack(spacing: .zero) {
            Text(region.displayName)
              .fonts(.bodyLargeMedium)
              .foregroundColor(
                selected == region
                ? Color.white
                : Asset.Colors.neutral.color
              )
              .frame(height: 48)
              .padding(.horizontal, 20)
            Spacer()
          }
        }
        .background(
          selected == region
          ? Asset.Colors.neutral.color
          : Color.clear
        )
      }
      Spacer()
    }
  }
}

struct DistrictSelectView: View {
  @State private var selected: District?
  let districts: [District]
  var completion: (District) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(districts) { district in
        Button {
          selected = district
          completion(district)
        } label: {
          HStack(spacing: .zero) {
            Text(district.displayName)
              .fonts(.bodyLargeMedium)
              .foregroundColor(
                selected == district
                ? Color.white
                : Asset.Colors.neutral.color
              )
              .frame(height: 48)
              .padding(.horizontal, 20)
            Spacer()
          }
        }
        .background(
          selected == district
          ? Asset.Colors.neutral.color
          : Color.clear
        )
      }
      Spacer()
    }
  }
}
