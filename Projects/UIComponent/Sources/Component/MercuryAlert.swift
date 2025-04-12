//
//  MercuryAlert.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

protocol MercuryAlertable {
  func present(_ information: OnlyConfirmAlertInformation)
}

public enum AlertInformType {
  case onlyConfirm(information: OnlyConfirmAlertInformation)
  case cancallable(information: CancellableAlertInformation)
}

public struct OnlyConfirmAlertInformation {
  let title: String
  let description: String
  let confirmButtonTitle: String
  let onConfirm: () -> Void
}

public struct CancellableAlertInformation {
  let title: String
  let description: String
  let confirmButtonTitle: String
  let cancelButtonTitle: String
  let onConfirm: () -> Void
  let onCancel: () -> Void
}

public struct MercuryAlert: View {
  // MARK: - private property
  private let type: AlertInformType
  
  // MARK: - life cycle
  public init(_ type: AlertInformType) {
    self.type = type
  }
  
  public var body: some View {
    
    ZStack {
      switch type {
      case .onlyConfirm(let information):
        VStack(spacing: .zero) {
          VStack(spacing: 8) {
            HStack(spacing: .zero) {
              Text(information.title)
                .fonts(.titleLargeBold)
                .foregroundStyle(Asset.Colors.textDefault.color)
              Spacer()
            }
            HStack(spacing: .zero) {
              Text(information.description)
                .foregroundStyle(Asset.Colors.textSubText.color)
                .fonts(.bodyMediumMedium)
            }
          }
          .padding(.bottom, 24)
          
          MercuryButton(information.title, completion: information.onConfirm)
          
        }
      case .cancallable(let information):
        VStack(spacing: .zero) {
          VStack(spacing: 8) {
            HStack(spacing: .zero) {
              Text(information.title)
                .fonts(.titleLargeBold)
                .foregroundStyle(Asset.Colors.textDefault.color)
              Spacer()
            }
            HStack(spacing: .zero) {
              Text(information.description)
                .foregroundStyle(Asset.Colors.textSubText.color)
                .fonts(.bodyMediumMedium)
            }
          }
          .padding(.bottom, 24)
          
          MercuryButton(information.title, completion: information.onConfirm)
          
        }
      }
      
    }
    .shadows(.shadowHigh)
  }
}

