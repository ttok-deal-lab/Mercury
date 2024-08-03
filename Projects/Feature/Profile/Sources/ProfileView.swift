//
//  ProfileView.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import ComposableArchitecture

public struct ProfileView: View {
  public var store: StoreOf<ProfileReducer>
  
  public var body: some View {
    Text("Profile")
  }
  
  public init(store: StoreOf<ProfileReducer>) {
    self.store = store
  }
  
}
