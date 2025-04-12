//
//  AlertTestView.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

import UIComponent

struct AlertTestView: View {
  @State var isShowAlert: Bool = false
  var body: some View {
    Button {
      isShowAlert.toggle()
    } label: {
      Text("show alert")
    }
    .windowCover(isPresented: $isShowAlert) {
      MercuryAlert(isPresented: $isShowAlert, type: .cancallable(information: AlertCancellableInformation(title: "title", description: "description", confirmButtonTitle: "confirm", cancelButtonTitle: "cancel", onConfirm: { print("11" )}, onCancel: { print("22")})))
    }
    
  }
}
