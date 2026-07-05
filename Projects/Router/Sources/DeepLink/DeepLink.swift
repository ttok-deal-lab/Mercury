//
//  DeepLink.swift
//  Router
//
//  Created by DevLifter on 7/6/26.
//

import Foundation

/// `estateSlug://` 스킴으로 표현되는 딥링크 목적지.
public enum DeepLink: Hashable {
  case auctionDetail(id: Int)
  case search(keyword: String)
  case tab(AppTab)
}
