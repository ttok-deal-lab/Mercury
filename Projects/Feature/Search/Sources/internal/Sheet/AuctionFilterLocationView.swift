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
  @Binding var modelData: SearchModelData
  
  var onApplied: (() -> Void)
  
  var region: [Region]? {
    modelData.auctionSearchFilter?.regions
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      HStack(spacing: .zero) {
        Text("지역 선택")
          .fonts(.titleLargeBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        Spacer()
        
        Button {
          onApplied()
        } label: {
          Text("적용")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
        
      }
      .padding(.top, 50)
      .padding(.bottom, 16)
      .padding(.horizontal, 20)
      
      Rectangle()
        .foregroundStyle(Asset.Colors.neutralLight.color)
        .frame(height: 1)
        .frame(maxWidth: .infinity)
      
      ScrollView(.vertical) {
        VStack(spacing: .zero) {
          HStack(spacing: .zero) {
            RegionsSelectView(
              currentRegion: $modelData.currentAuctionFilter.region,
              regions: region
            ) { _ in 
              modelData.currentAuctionFilter.district = nil
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 16)
            
            if let selectedRegion = modelData.currentAuctionFilter.region {
              DistrictSelectView(
                selectedDistrict: $modelData.currentAuctionFilter.district,
                districts: selectedRegion.districts
              )
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(.vertical, 16)
            }
          }
        }
      }
    }
  }
}

struct RegionsSelectView: View {
  @Binding var currentRegion: Region?
  let regions: [Region]?
  var completion: (Region) -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(regions ?? []) { region in
        Button {
          currentRegion = region
          completion(region)
        } label: {
          HStack(spacing: .zero) {
            Text(region.displayName)
              .fonts(.bodyLargeMedium)
              .foregroundColor(
                currentRegion == region
                ? .white
                : Asset.Colors.neutral.color
              )
              .frame(height: 48)
              .padding(.horizontal, 20)
            
            Spacer()
          }
        }
        .background(
          currentRegion == region
          ? Asset.Colors.neutral.color
          : .clear
        )
      }
      Spacer()
    }
  }
}

struct DistrictSelectView: View {
  @Binding var selectedDistrict: District?
  let districts: [District]
  
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      ForEach(districts) { district in
        Button {
          selectedDistrict = district
        } label: {
          HStack(spacing: .zero) {
            Text(district.displayName)
              .fonts(.bodyLargeMedium)
              .foregroundColor(
                selectedDistrict == district
                ? Color.white
                : Asset.Colors.neutral.color
              )
              .frame(height: 48)
              .padding(.horizontal, 20)
            Spacer()
          }
        }
        .background(
          selectedDistrict == district
          ? Asset.Colors.neutral.color
          : Color.clear
        )
      }
      Spacer()
    }
  }
}

