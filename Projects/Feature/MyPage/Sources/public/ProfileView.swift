//
//  ProfileView.swift
//  MyPage
//
//  Created by 최수훈 on 10/29/25.
//

import SwiftUI

struct ProfileView: View {
  var image: Image?
  var menuItem: String
  
  var body: some View {
    HStack {
      image
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4.5))
      Text(menuItem)
      Spacer()
    }
    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
  }
}
