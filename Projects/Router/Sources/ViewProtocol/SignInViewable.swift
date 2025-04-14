//
//  SignInViewable.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

public protocol SignInViewable where Self: View {
  init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>)
}
