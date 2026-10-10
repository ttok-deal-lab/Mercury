//
//  CrewLeaderReportFilePickerView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI
import UniformTypeIdentifiers

import UIComponent

struct CrewLeaderReportFilePickerView: View {
  
  @Binding var fileURL: URL?
  @State private var isImporterPresented: Bool = false
  
  var body: some View {
    HStack(spacing: 8) {
      Text(fileURL?.lastPathComponent ?? L10n.reportLeaderProfileReportPlaceholder)
        .fonts(.bodySmallMedium)
        .foregroundStyle(fileURL == nil ? Asset.Colors.neutralSubtle.color : Asset.Colors.neutral.color)
        .lineLimit(1)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .frame(height: 48)
        .background(Asset.Colors.neutralLight.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Button {
        isImporterPresented = true
      } label: {
        Text(L10n.reportLeaderProfileReportSelect)
          .fonts(.bodySmallBold)
          .foregroundStyle(Asset.Colors.primary.color)
          .padding(.horizontal, 16)
          .frame(height: 48)
          .overlay {
            RoundedRectangle(cornerRadius: 8)
              .stroke(Asset.Colors.primary.color, lineWidth: 1)
          }
      }
    }
    .fileImporter(isPresented: $isImporterPresented, allowedContentTypes: [.item]) { result in
      if case .success(let url) = result {
        fileURL = url
      }
    }
  }
}
