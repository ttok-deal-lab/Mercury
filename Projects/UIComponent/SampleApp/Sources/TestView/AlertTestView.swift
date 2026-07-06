//
//  AlertTestView.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI
import AppFoundation

import UIComponent

struct AlertTestView: View {
  @State var isShowAlert: Bool = false
  var body: some View {
    Button {
      MercuryAlert.shared
        .present(
          type: .cancallable(
            information: AlertCancellableInformation(
              title: "title",
              description: "description",
              confirmButtonTitle: "confirm",
              cancelButtonTitle: "cancel",
              onConfirm: {
                Log.debug("11")
              },
              onCancel: {
                Log.debug("22")
              }
            )
          )
        )
    } label: {
      Text("show alert")
    }
    
  }
}
