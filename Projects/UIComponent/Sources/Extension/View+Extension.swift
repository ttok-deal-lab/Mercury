//
//  View+Extension.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//
import SwiftUI

public extension View {
    func imageCache(_ cache: ImageCache) -> some View {
        environment(\.imageCache, cache)
    }
}
