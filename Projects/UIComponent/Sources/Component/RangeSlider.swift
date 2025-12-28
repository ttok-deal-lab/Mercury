//
//  RangeSlider.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

public struct PriceRangeSlider: View {
  @Binding private var range: ClosedRange<Double>
  private let bounds: ClosedRange<Double>
  private let step: Double
  
  private let trackHeight: CGFloat = 8
  private let thumbSize: CGFloat = 30
  private let activeColor: Color = Asset.Colors.primary.color
  private let inactiveColor: Color = Asset.Colors.neutralWeak.color
  
  public init(range: Binding<ClosedRange<Double>>, bounds: ClosedRange<Double>, step: Double = 1_000_000) {
    self._range = range
    self.bounds = bounds
    self.step = step
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text(currentRangeText)
        .fonts(.bodyLargeMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 12)
      
      GeometryReader { geometry in
        ZStack(alignment: .leading) {
          Capsule()
            .fill(inactiveColor)
            .frame(height: trackHeight)
          
          Capsule()
            .fill(activeColor)
            .frame(height: trackHeight)
            .offset(x: leftThumbOffset(in: geometry.size.width))
            .frame(width: activeTrackWidth(in: geometry.size.width))
          
          SliderThumb(size: thumbSize, color: activeColor)
            .offset(x: leftThumbOffset(in: geometry.size.width))
            .gesture(
              DragGesture()
                .onChanged { value in
                  handleDrag(value: value, isLeftThumb: true, width: geometry.size.width)
                }
            )
          
          SliderThumb(size: thumbSize, color: activeColor)
            .offset(x: rightThumbOffset(in: geometry.size.width))
            .gesture(
              DragGesture()
                .onChanged { value in
                  handleDrag(value: value, isLeftThumb: false, width: geometry.size.width)
                }
            )
        }
        .frame(height: thumbSize)
      }
      .frame(height: thumbSize)
      
      HStack {
        Text(Int(bounds.lowerBound).toKoreanFullWon)
        Spacer()
        Text(Int(bounds.upperBound).toKoreanFullWon)
      }
      .fonts(.bodyMicroMedium)
      .foregroundStyle(Asset.Colors.neutralSubtler.color)
      .padding(.top, 14)
    }
    .padding(.horizontal, 20)
  }
  
  // MARK: - Logic Helpers
  
  private var currentRangeText: String {
    if range.lowerBound == bounds.lowerBound && range.upperBound == bounds.upperBound {
      return "전체"
    } else if range.lowerBound == bounds.lowerBound {
      return "\(Int(range.upperBound).toKoreanFullWon) 이하"
    } else if range.upperBound == bounds.upperBound {
      return "\(Int(range.lowerBound).toKoreanFullWon) 이상"
    } else {
      return "\(Int(range.lowerBound).toKoreanFullWon) ~ \(Int(range.upperBound).toKoreanFullWon)"
    }
  }
  
  private func leftThumbOffset(in width: CGFloat) -> CGFloat {
    let percentage = (range.lowerBound - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
    return CGFloat(percentage) * (width - thumbSize)
  }
  
  private func rightThumbOffset(in width: CGFloat) -> CGFloat {
    let percentage = (range.upperBound - bounds.lowerBound) / (bounds.upperBound - bounds.lowerBound)
    return CGFloat(percentage) * (width - thumbSize)
  }
  
  private func activeTrackWidth(in width: CGFloat) -> CGFloat {
    let left = leftThumbOffset(in: width)
    let right = rightThumbOffset(in: width)
    return right - left + thumbSize
  }
  
  // 드래그 처리
  private func handleDrag(value: DragGesture.Value, isLeftThumb: Bool, width: CGFloat) {
    let x = value.location.x
    let percentage = x / (width - thumbSize)
    let calculatedValue = bounds.lowerBound + (Double(percentage) * (bounds.upperBound - bounds.lowerBound))
    
    // 스텝 단위로 끊기 (스냅 효과)
    let steppedValue = round(calculatedValue / step) * step
    let clampedValue = min(max(steppedValue, bounds.lowerBound), bounds.upperBound)
    
    if isLeftThumb {
      let newLower = min(clampedValue, range.upperBound)
      range = newLower...range.upperBound
    } else {
      let newUpper = max(clampedValue, range.lowerBound)
      range = range.lowerBound...newUpper
    }
  }
}

struct SliderThumb: View {
  let size: CGFloat
  let color: Color
  
  var body: some View {
    ZStack {
      Circle()
        .fill(.white)
        .frame(width: size, height: size)
        .shadow(color: .black.opacity(0.15), radius: 3, x: 0, y: 2)
      
      Circle()
        .strokeBorder(color, lineWidth: 4) // 파란색 테두리
        .frame(width: size, height: size)
    }
  }
}
