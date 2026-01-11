//
//  MailService.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/9/26.
//

import SwiftUI

import Domain
import UIComponent

public struct MailManager: MailManagerable {
  
  public init() { }
  
  public func openMail(recipient: String, title: String, body: String) {
    var components = URLComponents()
    components.scheme = "googlegmail"
    components.path = "/co"
    components.queryItems = [
      URLQueryItem(name: "to", value: recipient),
      URLQueryItem(name: "subject", value: title),
      URLQueryItem(name: "body", value: body)
    ]
    
    guard let gmailUrl = components.url else { return }
    
    if UIApplication.shared.canOpenURL(gmailUrl) {
      UIApplication.shared.open(gmailUrl)
    } else {
      // Gmail이 없으면 '기본 메일 앱'으로 Fallback (mailto:)
      if let mailtoUrl = URL(string: "mailto:\(recipient)") {
        if UIApplication.shared.canOpenURL(mailtoUrl) {
          UIApplication.shared.open(mailtoUrl)
        } else {
          Task { @MainActor in
            MercuryAlert.shared.present(
              type:
                  .confirmable(
                    information: AlertConfirmInformation(
                      title: "메일을 보낼 수 있는 앱이 없습니다.",
                      description: "",
                      confirmButtonTitle: L10n.commonConfirm,
                      onConfirm: {
                        
                      }
                    )
                  )
            )
          }
        }
      }
    }
  }
}
