//
//  ImageTestView.swift
//  UIComponent
//
//  Created by 송하민 on 4/2/25.
//

import Foundation
import SwiftUI

import UIComponent

struct ImageTestView: View {
  var body: some View {
    let columns: [GridItem] = [
      GridItem(.adaptive(minimum: 30), spacing: 10)
    ]
    LazyVGrid(columns: columns) {
      ForEach(images.indices, id: \.self) { index in
        images[index]
          .resizable()
          .frame(width: 30, height: 30)
      }
    }
  }
  
  var images: [Image] = [
    Asset.Images.updown.image,
    Asset.Images.arrowDownNoShaft.image,
    Asset.Images.arrowDown.image,
    Asset.Images.arrowLeftNoShaft.image,
    Asset.Images.arrowLeft.image,
    Asset.Images.arrowRightNoShaft.image,
    Asset.Images.arrowRight.image,
    Asset.Images.arrowUpNoShaft.image,
    Asset.Images.arrowUp.image,
    Asset.Images.chevronUp.image,
    Asset.Images.chevronDown.image,
    Asset.Images.chevronLeft.image,
    Asset.Images.chevronRight.image,
    Asset.Images.closePassword.image,
    Asset.Images.close.image,
    Asset.Images.edit.image,
    Asset.Images.minus.image,
    Asset.Images.plus.image,
    Asset.Images.roundPlus.image,
    Asset.Images.addPhoto.image,
    Asset.Images.bellFillDot.image,
    Asset.Images.bellFill.image,
    Asset.Images.build.image,
    Asset.Images.call.image,
    Asset.Images.camera.image,
    Asset.Images.charge.image,
    Asset.Images.check.image,
    Asset.Images.clock.image,
    Asset.Images.coin.image,
    Asset.Images.coupon.image,
    Asset.Images.danger.image,
    Asset.Images.delete.image,
    Asset.Images.edit.image,
    Asset.Images.filter.image,
    Asset.Images.graph.image,
    Asset.Images.invisible.image,
    Asset.Images.location.image,
    Asset.Images.mapFill.image,
    Asset.Images.noti.image,
    Asset.Images.parking.image,
    Asset.Images.person.image,
    Asset.Images.placeTime.image,
    Asset.Images.place.image,
    Asset.Images.starHalf.image,
    Asset.Images.star.image,
    Asset.Images.visible.image,
    Asset.Images.warning.image,
    Asset.Images.calendar1.image,
    Asset.Images.calendar2.image,
    Asset.Images.gallery.image,
    Asset.Images.heart.image,
    Asset.Images.homeOff.image,
    Asset.Images.homeOn.image,
    Asset.Images.reportOff.image,
    Asset.Images.reportOn.image,
    Asset.Images.infoFill.image,
    Asset.Images.infoLine.image,
    Asset.Images.questionFill.image,
    Asset.Images.questionLine.image,
    Asset.Images.sucessFill.image,
    Asset.Images.sucessLine.image,
    Asset.Images.download.image,
    Asset.Images.edit.image,
    Asset.Images.expand.image,
    Asset.Images.export.image,
    Asset.Images.filter3dot.image,
    Asset.Images.info.image,
    Asset.Images.loading.image,
    Asset.Images.menuH.image,
    Asset.Images.notification.image,
    Asset.Images.placeLocation.image,
    Asset.Images.redo.image,
    Asset.Images.reduce.image,
    Asset.Images.search.image,
    Asset.Images.settingFill.image,
    Asset.Images.setting.image,
    Asset.Images.undo.image,
    Asset.Images.listThreeLine.image,
    Asset.Images.listTwoLine.image,
    Asset.Images.qnA1.image,
    Asset.Images.qnA2.image,
    Asset.Images.card.image,
    Asset.Images.coupone.image,
    Asset.Images.event.image,
    Asset.Images.government.image,
    Asset.Images.inquire.image,
    Asset.Images.manageCard.image,
    Asset.Images.notice.image,
    Asset.Images.report.image,
    Asset.Images.requestUpdate.image,
    Asset.Images.creditCard.image,
    Asset.Images.lpay.image,
    Asset.Images.naverPay1.image,
    Asset.Images.naverPay2.image,
    Asset.Images.payco.image,
    Asset.Images.apple.image,
    Asset.Images.google.image,
    Asset.Images.kakao.image,
    Asset.Images.naver.image
  ]
}

