// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
public typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum Asset {
  public enum Colors {
    public static let backgroundDefault = ColorAsset(name: "BackgroundDefault")
    public static let backgroundMuted = ColorAsset(name: "BackgroundMuted")
    public static let borderDark = ColorAsset(name: "BorderDark")
    public static let borderDefault = ColorAsset(name: "BorderDefault")
    public static let borderError = ColorAsset(name: "BorderError")
    public static let borderSuccess = ColorAsset(name: "BorderSuccess")
    public static let buttonBlackDefault = ColorAsset(name: "ButtonBlackDefault")
    public static let buttonBlackDisabled = ColorAsset(name: "ButtonBlackDisabled")
    public static let buttonBlackPressed = ColorAsset(name: "ButtonBlackPressed")
    public static let buttonGrayDefault = ColorAsset(name: "ButtonGrayDefault")
    public static let buttonGrayDisabled = ColorAsset(name: "ButtonGrayDisabled")
    public static let buttonGrayPressed = ColorAsset(name: "ButtonGrayPressed")
    public static let buttonPrimaryDefault = ColorAsset(name: "ButtonPrimaryDefault")
    public static let buttonPrimaryDisabled = ColorAsset(name: "ButtonPrimaryDisabled")
    public static let buttonPrimaryPressed = ColorAsset(name: "ButtonPrimaryPressed")
    public static let textBlack = ColorAsset(name: "TextBlack")
    public static let textDefault = ColorAsset(name: "TextDefault")
    public static let textDisabled = ColorAsset(name: "TextDisabled")
    public static let textError = ColorAsset(name: "TextError")
    public static let textSubText = ColorAsset(name: "TextSubText")
    public static let textSuccess = ColorAsset(name: "TextSuccess")
    public static let textWhite = ColorAsset(name: "TextWhite")
  }
  public enum Images {
    public static let apartment = ImageAsset(name: "apartment")
    public static let factory = ImageAsset(name: "factory")
    public static let house = ImageAsset(name: "house")
    public static let land = ImageAsset(name: "land")
    public static let offictel = ImageAsset(name: "offictel")
    public static let store = ImageAsset(name: "store")
    public static let naverCircle = ImageAsset(name: "naver_circle")
    public static let naverLogout = ImageAsset(name: "naver_logout")
    public static let naverSimple = ImageAsset(name: "naver_simple")
    public static let naverSquare = ImageAsset(name: "naver_square")
    public static let naverStandard = ImageAsset(name: "naver_standard")
    public static let smililingKiss = ImageAsset(name: "smililingKiss")
    public static let sunglasses = ImageAsset(name: "sunglasses")
    public static let thinking = ImageAsset(name: "thinking")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class ColorAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = SwiftUI.Color
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  init?(asset: ColorAsset) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS)
    self.init(asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}



public struct ImageAsset {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias NSImage = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias UIKitImage = UIImage
  public typealias Image = SwiftUI.Image
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS)
    let image = Image(name, bundle: bundle)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    return image
  }
}

public extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

