//
//  CoordinatorManager.swift
//  MercuryApp
//
//  Created by 송하민 on 10/5/24.
//

import Foundation
import SwiftUI

@MainActor
public class CoordinatorManager: ObservableObject {
  
  @Published public var rootPage: AppPage?
  
  @Published public var path: NavigationPath = NavigationPath()
  @Published public var fullScreenCoverPath: NavigationPath = NavigationPath()
  
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
  
  public func presentSheet(page: AppPage) {
    self.sheet = page
  }
  
  public func presentFullScreenCover(page: AppPage) {
    self.fullScreenCover = page
  }
  
  public func pushOnFullScreenCover(page: AppPage) {
    self.fullScreenCoverPath.append(page)
  }
  
  public func dismissSheet() {
    self.sheet = nil
  }
  
  public func dismissCover() {
    self.fullScreenCover = nil
  }
  
  public func changeBaseView(page: AppPage) {
    self.rootPage = page
  }
  
}
