//
//  CoordinatorManager.swift
//  MercuryApp
//
//  Created by 송하민 on 10/5/24.
//

import Foundation
import SwiftUI

public class CoordinatorManager: ObservableObject {
  
  @Published public var path: NavigationPath = NavigationPath()
  @Published public var sheet: AppPage?
  @Published public var fullScreenCover: AppPage?
  
  public init() { }
  
  public func push(page: AppPage) {
    path.append(page)
  }
  
  public func pop() {
    path.removeLast()
  }
  
  public func popToRoot() {
    path.removeLast(path.count)
  }
  
  public func presentSheet(_ sheet: AppPage) {
    self.sheet = sheet
  }
  
  public func presentFullScreenCover(_ cover: AppPage) {
    self.fullScreenCover = cover
  }
  
  public func dismissSheet() {
    self.sheet = nil
  }
  
  public func dismissCover() {
    self.fullScreenCover = nil
  }
  
}
