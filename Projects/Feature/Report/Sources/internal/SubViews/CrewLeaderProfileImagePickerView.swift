//
//  CrewLeaderProfileImagePickerView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI
import PhotosUI

import UIComponent

struct CrewLeaderProfileImagePickerView: View {
  
  @Binding var imageData: Data?
  @State private var selectedItem: PhotosPickerItem?
  @State private var previewImage: Image?
  
  var body: some View {
    PhotosPicker(selection: $selectedItem, matching: .images) {
      ZStack {
        Circle()
          .fill(Asset.Colors.gray150.color)
        
        if let previewImage {
          previewImage
            .resizable()
            .scaledToFill()
        }
      }
      .frame(width: 100, height: 100)
      .clipShape(Circle())
    }
    .onChange(of: selectedItem) { _, newItem in
      guard let newItem else { return }
      Task {
        // 업로드용 원본(Data) 과 미리보기용(Image) 을 따로 받아 UIKit 없이 표시한다.
        imageData = try? await newItem.loadTransferable(type: Data.self)
        previewImage = try? await newItem.loadTransferable(type: Image.self)
      }
    }
  }
}
