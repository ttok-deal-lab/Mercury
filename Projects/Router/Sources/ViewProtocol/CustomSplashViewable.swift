//
//  CustomSplashViewable.swift
//  Router
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI

public protocol CustomSplashViewable where Self: View {
  init(onComplete: @escaping (_ isSplashDone: Bool) -> Void)
}
