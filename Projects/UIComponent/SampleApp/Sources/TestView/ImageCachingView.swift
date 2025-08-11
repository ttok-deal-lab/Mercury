//
//  ImageCachingView.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//

import SwiftUI
import UIComponent

struct ImageChachingView: View {
  @State var imageUrl: String = ""
  
  var body: some View {
    CachedAsyncImage(url: URL(string: imageUrl), option: .onlyMemory) { image in
        image.resizable().scaledToFill()
    } placeholder: {
        ZStack {
            Color.gray.opacity(0.1)
            ProgressView()
        }
    }
    .frame(width: 100, height: 150)
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}
