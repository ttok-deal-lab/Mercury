//
//  Dependency+Extension.swift
//  Packages
//
//  Created by 송하민 on 7/11/24.
//

import ProjectDescription

public extension TargetDependency {
  
  nonisolated(unsafe) static var TCA: TargetDependency = .external(name: "ComposableArchitecture")
}
