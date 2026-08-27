//
//  OpenLicenseModelData.swift
//  Setting
//
//  Created by 최수훈 on 1/7/26.
//

import SwiftUI
import AppFoundation

@Observable
final class OpenLicenseModelData {
  var licenses: [OpenSourceItem] = []
  
  func loadLicenses() async {
    let bundle = Bundle.module
    
    guard let settingsBundleUrl = bundle.url(forResource: "Settings", withExtension: "bundle"),
          let settingsBundle = Bundle(url: settingsBundleUrl)
    else {
      Log.debug("Settings.bundle 을 찾을 수 없습니다.")
      return
    }
    
    // 목록 (com.mono0926.LicensePlist.plist) 찾기
    guard let url = settingsBundle.url(forResource: "com.mono0926.LicensePlist", withExtension: "plist")
    else {
      Log.debug("❌ plist 목록 파일을 찾을 수 없습니다.")
      return
    }
    
    do {
      let data = try Data(contentsOf: url)
      let root = try PropertyListDecoder().decode(LicenseRoot.self, from: data)
      
      let loadedItems = root.preferenceSpecifiers.compactMap { item -> OpenSourceItem? in
        guard let title = item.title,
              let fileName = item.file
        else {
          return nil
        }
        
        guard let contentUrl = settingsBundle.url(forResource: fileName, withExtension: "plist"),
              let contentData = try? Data(contentsOf: contentUrl),
              let detailRoot = try? PropertyListDecoder().decode(
                LicenseDetailRoot.self,
                from: contentData
              ),
              let content = detailRoot.preferenceSpecifiers.first?.footerText
        else {
          Log.debug("\(title)의 상세 내용을 찾을 수 없습니다.")
          return nil
        }
        return OpenSourceItem(title: title, licenseContent: content)
      }
      
      self.licenses = loadedItems.sorted { $0.title > $1.title }
    } catch {
      Log.debug("\(#function) Error for parse License: \(error)")
    }
  }
}
