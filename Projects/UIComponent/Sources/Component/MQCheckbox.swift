//
//  MQCheckbox.swift
//  UIComponent
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI

public struct MQCheckbox: View {

  public enum CheckType {
    case square
    case circle
  }
  
  @Binding var isChecked: Bool
  let checkType: CheckType
  let checkColor: Color
  let uncheckColor: Color
  
  public init(type: CheckType, checkColor: Color, unCheckColor: Color = .gray, isChecked: Binding<Bool>) {
    self.checkType = type
    self.checkColor = checkColor
    self.uncheckColor = unCheckColor
    self._isChecked = isChecked
  }
  
  public var body: some View {
    HStack {
      Button(action: {
        self.isChecked.toggle()
      }) {
        Image(systemName: boxImageSystemName())
          .foregroundColor(isChecked ? checkColor : uncheckColor)
          .font(.system(size: 24))
      }
      .buttonStyle(PlainButtonStyle())
    }
  }
  
  private func boxImageSystemName() -> String {
    if isChecked {
      switch checkType {
      case .square:
        return "checkmark.square.fill"
      case .circle:
        return "checkmark.circle.fill"
      }
    } else {
      switch checkType {
      case .square:
        return "square"
      case .circle:
        return "circle"
      }
    }
  }
}

#Preview {
  MQCheckbox(type: .square, checkColor: .black, isChecked: .constant(false))
}
