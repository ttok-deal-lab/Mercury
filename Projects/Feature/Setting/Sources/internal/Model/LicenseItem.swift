//
//  LicenseItem.swift
//  Setting
//
//  Created by 최수훈 on 1/7/26.
//

// 목록 파일용
struct LicenseRoot: Decodable {
    let preferenceSpecifiers: [LicenseSpecifier]
    enum CodingKeys: String, CodingKey { case preferenceSpecifiers = "PreferenceSpecifiers" }
}

struct LicenseSpecifier: Decodable {
    let title: String?
    let file: String?
    enum CodingKeys: String, CodingKey { case title = "Title"; case file = "File" }
}

// 상세 파일용
struct LicenseDetailRoot: Decodable {
    let preferenceSpecifiers: [LicenseDetailSpecifier]
    enum CodingKeys: String, CodingKey { case preferenceSpecifiers = "PreferenceSpecifiers" }
}

struct LicenseDetailSpecifier: Decodable {
    let footerText: String?
    enum CodingKeys: String, CodingKey { case footerText = "FooterText" }
}
