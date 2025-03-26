// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
import Foundation// MARK: - Swift Bundle Accessor for Frameworks
private class BundleFinder {}
extension Foundation.Bundle {
/// Since Analysis is a dynamic framework, the bundle for classes within this module can be used directly.
static let module = Bundle(for: BundleFinder.self)
}// MARK: - Objective-C Bundle Accessor
@objc
public class AnalysisResources: NSObject {
@objc public class var bundle: Bundle {
    return .module
}
}// swiftlint:enable all
// swiftformat:enable all