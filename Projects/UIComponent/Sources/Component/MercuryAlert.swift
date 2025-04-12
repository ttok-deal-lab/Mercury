//
//  MercuryAlert.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

import AppFoundation

public struct MercuryAlert: View {
  @State private var animate: Bool = false
  @Binding private var isPresented: Bool
  private let type: AlertInformType
   
  // MARK: - life cycle
  
  public init(isPresented: Binding<Bool>, type: AlertInformType) {
    self._isPresented = isPresented
    self.type = type
  }
  
  // MARK: - life cycle
  
  public var body: some View {
    ZStack {
      Asset.Colors.textWhite.color
      VStack(spacing: .zero) {
        switch type {
        case .confirmable(let information):
          confirmableAlertView(information: information)
        case .cancallable(let information):
          cancellableAlertView(information: information)
        }
      }
      .padding(.vertical, 24)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding(.horizontal, 24)
    .fixedSize(horizontal: false, vertical: true)
    .shadows(.shadowHigh)
    .scaleEffect(animate ? 1 : 0.8)
    .opacity(animate ? 1 : 0)
    .onAppear {
      withAnimation(.easeInOut(duration: 0.1)) {
        animate = true
      }
    }
    .onDisappear {
      animate = false
    }
  }
  
  // MARK: - private method
  
  private func dismiss(withAction action: @escaping () -> Void) {
    let syncTime: CGFloat = 0.1
    withAnimation(.easeInOut(duration: syncTime)) {
      animate = false
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + syncTime) {
      isPresented = false
      action()
    }
  }
  
  private func confirmableAlertView(information: AlertConfirmInformation) -> some View {
    VStack(spacing: .zero) {
      VStack(spacing: 8) {
        HStack(spacing: .zero) {
          Text(information.title)
            .fonts(.titleLargeBold)
            .foregroundStyle(Asset.Colors.textDefault.color)
          Spacer()
        }
        .padding(.horizontal, 24)
        
        HStack(spacing: .zero) {
          Text(information.description)
            .foregroundStyle(Asset.Colors.textSubText.color)
            .fonts(.bodyMediumMedium)
          Spacer()
        }
        .padding(.horizontal, 24)
      }
      .padding(.bottom, 24)
      
      MercuryButton(
        information.confirmButtonTitle,
        completion: {
          dismiss {
            information.onConfirm()
          }
        }
      )
      .padding(.horizontal, 24)
    }
    .padding(.vertical, 24)
  }
  
  private func cancellableAlertView(information: AlertCancellableInformation) -> some View {
    VStack(spacing: .zero) {
      VStack(spacing: 8) {
        HStack(spacing: .zero) {
          Text(information.title)
            .fonts(.titleLargeBold)
            .foregroundStyle(Asset.Colors.textDefault.color)
          Spacer()
        }
        .padding(.horizontal, 24)
        
        HStack(spacing: .zero) {
          Text(information.description)
            .foregroundStyle(Asset.Colors.textSubText.color)
            .fonts(.bodyMediumMedium)
          Spacer()
        }
        .padding(.horizontal, 24)
      }
      .padding(.bottom, 24)
      
      HStack(spacing: .zero) {
        HStack(spacing: 7) {
          MercuryButton(
            type: .secondary,
            information.cancelButtonTitle,
            completion: {
              dismiss {
                information.onCancel()
              }
            }
          )
          MercuryButton(
            information.confirmButtonTitle,
            completion: {
              dismiss {
                information.onConfirm()
              }
            }
          )
        }
      }
      .padding(.horizontal, 24)
    }
  }
}

public enum AlertInformType {
  case confirmable(information: AlertConfirmInformation)
  case cancallable(information: AlertCancellableInformation)
}

public struct AlertConfirmInformation {
  let title: String
  let description: String
  let confirmButtonTitle: String
  let onConfirm: () -> Void
  
  public init(title: String, description: String, confirmButtonTitle: String, onConfirm: @escaping () -> Void) {
    self.title = title
    self.description = description
    self.confirmButtonTitle = confirmButtonTitle
    self.onConfirm = onConfirm
  }
}

public struct AlertCancellableInformation {
  let title: String
  let description: String
  let confirmButtonTitle: String
  let cancelButtonTitle: String
  let onConfirm: () -> Void
  let onCancel: () -> Void
  
  public init(title: String, description: String, confirmButtonTitle: String, cancelButtonTitle: String, onConfirm: @escaping () -> Void, onCancel: @escaping () -> Void) {
    self.title = title
    self.description = description
    self.confirmButtonTitle = confirmButtonTitle
    self.cancelButtonTitle = cancelButtonTitle
    self.onConfirm = onConfirm
    self.onCancel = onCancel
  }
}
