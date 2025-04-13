//
//  TabbarViewable.swift
//  Router
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

public protocol ProfileViewable where Self: View {
  init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>)
}
