//
//  RangeSlider.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

public struct RangeSlider: View {
  @Binding var lowerValue: Double
  @Binding var upperValue: Double
  public let range: ClosedRange<Double>
  private let thumbSize: CGFloat = 30
  
  public init(lowerValue: Binding<Double>, upperValue: Binding<Double>, range: ClosedRange<Double>) {
    self._lowerValue = lowerValue
    self._upperValue = upperValue
    self.range = range
  }
  
  public var body: some View {
    GeometryReader { geometry in
      let width = geometry.size.width
      let height = geometry.size.height
      let totalRange = range.upperBound - range.lowerBound
      
      let lowerRatio = (lowerValue - range.lowerBound) / totalRange
      let upperRatio = (upperValue - range.lowerBound) / totalRange
      
      let lowerX = CGFloat(lowerRatio) * width
      let upperX = CGFloat(upperRatio) * width
      
      ZStack {
        Capsule()
          .fill(Asset.Colors.neutralWeak.color)
          .frame(height: 8)
          .position(x: width / 2, y: height / 2)
        
        Capsule()
          .fill(Asset.Colors.primary.color)
          .frame(width: upperX - lowerX, height: 8)
          .position(x: (upperX + lowerX) / 2, y: height / 2)
        
        Circle()
          .fill(Asset.Colors.primaryLight.color)
          .overlay(Circle().stroke(Asset.Colors.primary.color, lineWidth: 4))
          .frame(width: thumbSize, height: thumbSize)
          .position(x: lowerX, y: height / 2)
          .gesture(
            DragGesture()
              .onChanged { value in
                let ratio = max(0, min(1, value.location.x / width))
                let newValue = range.lowerBound + Double(ratio) * totalRange
                lowerValue = min(max(range.lowerBound, newValue), upperValue)
              }
          )
        
        Circle()
          .fill(Asset.Colors.primaryLight.color)
          .overlay(Circle().stroke(Asset.Colors.primary.color, lineWidth: 4))
          .frame(width: thumbSize, height: thumbSize)
          .position(x: upperX, y: height / 2)
          .gesture(
            DragGesture()
              .onChanged { value in
                let ratio = max(0, min(1, value.location.x / width))
                let newValue = range.lowerBound + Double(ratio) * totalRange
                upperValue = max(min(range.upperBound, newValue), lowerValue)
              }
          )
      }
    }
    .padding(.horizontal, thumbSize / 2)
    .frame(height: 44)
  }
}
