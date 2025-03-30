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
    public static let black = ColorAsset(name: "Black")
    public static let blue10 = ColorAsset(name: "Blue_10")
    public static let blue100 = ColorAsset(name: "Blue_100")
    public static let blue150 = ColorAsset(name: "Blue_150")
    public static let blue200 = ColorAsset(name: "Blue_200")
    public static let blue300 = ColorAsset(name: "Blue_300")
    public static let blue400 = ColorAsset(name: "Blue_400")
    public static let blue50 = ColorAsset(name: "Blue_50")
    public static let blue600 = ColorAsset(name: "Blue_600")
    public static let blue700 = ColorAsset(name: "Blue_700")
    public static let blue800 = ColorAsset(name: "Blue_800")
    public static let blue900 = ColorAsset(name: "Blue_900")
    public static let dim = ColorAsset(name: "Dim")
    public static let gray10 = ColorAsset(name: "Gray_10")
    public static let gray100 = ColorAsset(name: "Gray_100")
    public static let gray20 = ColorAsset(name: "Gray_20")
    public static let gray200 = ColorAsset(name: "Gray_200")
    public static let gray30 = ColorAsset(name: "Gray_30")
    public static let gray300 = ColorAsset(name: "Gray_300")
    public static let gray40 = ColorAsset(name: "Gray_40")
    public static let gray400 = ColorAsset(name: "Gray_400")
    public static let gray50 = ColorAsset(name: "Gray_50")
    public static let gray500 = ColorAsset(name: "Gray_500")
    public static let gray60 = ColorAsset(name: "Gray_60")
    public static let gray600 = ColorAsset(name: "Gray_600")
    public static let gray70 = ColorAsset(name: "Gray_70")
    public static let gray700 = ColorAsset(name: "Gray_700")
    public static let gray80 = ColorAsset(name: "Gray_80")
    public static let gray800 = ColorAsset(name: "Gray_800")
    public static let gray90 = ColorAsset(name: "Gray_90")
    public static let green10 = ColorAsset(name: "Green_10")
    public static let green100 = ColorAsset(name: "Green_100")
    public static let green150 = ColorAsset(name: "Green_150")
    public static let green200 = ColorAsset(name: "Green_200")
    public static let green300 = ColorAsset(name: "Green_300")
    public static let green400 = ColorAsset(name: "Green_400")
    public static let green50 = ColorAsset(name: "Green_50")
    public static let green500 = ColorAsset(name: "Green_500")
    public static let green600 = ColorAsset(name: "Green_600")
    public static let green700 = ColorAsset(name: "Green_700")
    public static let green800 = ColorAsset(name: "Green_800")
    public static let green900 = ColorAsset(name: "Green_900")
    public static let lightBlue10 = ColorAsset(name: "Light Blue_10")
    public static let lightBlue100 = ColorAsset(name: "Light Blue_100")
    public static let lightBlue150 = ColorAsset(name: "Light Blue_150")
    public static let lightBlue200 = ColorAsset(name: "Light Blue_200")
    public static let lightBlue300 = ColorAsset(name: "Light Blue_300")
    public static let lightBlue400 = ColorAsset(name: "Light Blue_400")
    public static let lightBlue50 = ColorAsset(name: "Light Blue_50")
    public static let lightBlue500 = ColorAsset(name: "Light Blue_500")
    public static let lightBlue600 = ColorAsset(name: "Light Blue_600")
    public static let lightBlue700 = ColorAsset(name: "Light Blue_700")
    public static let lightBlue800 = ColorAsset(name: "Light Blue_800")
    public static let lightBlue900 = ColorAsset(name: "Light Blue_900")
    public static let mainBlue500 = ColorAsset(name: "Main Blue_500")
    public static let mainViolet500 = ColorAsset(name: "Main Violet_500")
    public static let mint10 = ColorAsset(name: "Mint_10")
    public static let mint100 = ColorAsset(name: "Mint_100")
    public static let mint150 = ColorAsset(name: "Mint_150")
    public static let mint200 = ColorAsset(name: "Mint_200")
    public static let mint300 = ColorAsset(name: "Mint_300")
    public static let mint400 = ColorAsset(name: "Mint_400")
    public static let mint50 = ColorAsset(name: "Mint_50")
    public static let mint500 = ColorAsset(name: "Mint_500")
    public static let mint600 = ColorAsset(name: "Mint_600")
    public static let mint700 = ColorAsset(name: "Mint_700")
    public static let mint800 = ColorAsset(name: "Mint_800")
    public static let mint900 = ColorAsset(name: "Mint_900")
    public static let orange10 = ColorAsset(name: "Orange_10")
    public static let orange100 = ColorAsset(name: "Orange_100")
    public static let orange150 = ColorAsset(name: "Orange_150")
    public static let orange200 = ColorAsset(name: "Orange_200")
    public static let orange300 = ColorAsset(name: "Orange_300")
    public static let orange400 = ColorAsset(name: "Orange_400")
    public static let orange50 = ColorAsset(name: "Orange_50")
    public static let orange500 = ColorAsset(name: "Orange_500")
    public static let orange600 = ColorAsset(name: "Orange_600")
    public static let orange700 = ColorAsset(name: "Orange_700")
    public static let orange800 = ColorAsset(name: "Orange_800")
    public static let orange900 = ColorAsset(name: "Orange_900")
    public static let pink10 = ColorAsset(name: "Pink_10")
    public static let pink100 = ColorAsset(name: "Pink_100")
    public static let pink150 = ColorAsset(name: "Pink_150")
    public static let pink200 = ColorAsset(name: "Pink_200")
    public static let pink300 = ColorAsset(name: "Pink_300")
    public static let pink400 = ColorAsset(name: "Pink_400")
    public static let pink50 = ColorAsset(name: "Pink_50")
    public static let pink500 = ColorAsset(name: "Pink_500")
    public static let pink600 = ColorAsset(name: "Pink_600")
    public static let pink700 = ColorAsset(name: "Pink_700")
    public static let pink800 = ColorAsset(name: "Pink_800")
    public static let pink900 = ColorAsset(name: "Pink_900")
    public static let pistachio10 = ColorAsset(name: "Pistachio_10")
    public static let pistachio100 = ColorAsset(name: "Pistachio_100")
    public static let pistachio150 = ColorAsset(name: "Pistachio_150")
    public static let pistachio200 = ColorAsset(name: "Pistachio_200")
    public static let pistachio300 = ColorAsset(name: "Pistachio_300")
    public static let pistachio400 = ColorAsset(name: "Pistachio_400")
    public static let pistachio50 = ColorAsset(name: "Pistachio_50")
    public static let pistachio500 = ColorAsset(name: "Pistachio_500")
    public static let pistachio600 = ColorAsset(name: "Pistachio_600")
    public static let pistachio700 = ColorAsset(name: "Pistachio_700")
    public static let pistachio800 = ColorAsset(name: "Pistachio_800")
    public static let pistachio900 = ColorAsset(name: "Pistachio_900")
    public static let red10 = ColorAsset(name: "Red_10")
    public static let red100 = ColorAsset(name: "Red_100")
    public static let red150 = ColorAsset(name: "Red_150")
    public static let red200 = ColorAsset(name: "Red_200")
    public static let red300 = ColorAsset(name: "Red_300")
    public static let red400 = ColorAsset(name: "Red_400")
    public static let red50 = ColorAsset(name: "Red_50")
    public static let red500 = ColorAsset(name: "Red_500")
    public static let red600 = ColorAsset(name: "Red_600")
    public static let red700 = ColorAsset(name: "Red_700")
    public static let red800 = ColorAsset(name: "Red_800")
    public static let red900 = ColorAsset(name: "Red_900")
    public static let salmon10 = ColorAsset(name: "Salmon_10")
    public static let salmon100 = ColorAsset(name: "Salmon_100")
    public static let salmon150 = ColorAsset(name: "Salmon_150")
    public static let salmon200 = ColorAsset(name: "Salmon_200")
    public static let salmon300 = ColorAsset(name: "Salmon_300")
    public static let salmon400 = ColorAsset(name: "Salmon_400")
    public static let salmon50 = ColorAsset(name: "Salmon_50")
    public static let salmon500 = ColorAsset(name: "Salmon_500")
    public static let salmon600 = ColorAsset(name: "Salmon_600")
    public static let salmon700 = ColorAsset(name: "Salmon_700")
    public static let salmon800 = ColorAsset(name: "Salmon_800")
    public static let salmon900 = ColorAsset(name: "Salmon_900")
    public static let sky10 = ColorAsset(name: "Sky_10")
    public static let sky100 = ColorAsset(name: "Sky_100")
    public static let sky150 = ColorAsset(name: "Sky_150")
    public static let sky200 = ColorAsset(name: "Sky_200")
    public static let sky300 = ColorAsset(name: "Sky_300")
    public static let sky400 = ColorAsset(name: "Sky_400")
    public static let sky50 = ColorAsset(name: "Sky_50")
    public static let sky500 = ColorAsset(name: "Sky_500")
    public static let sky600 = ColorAsset(name: "Sky_600")
    public static let sky700 = ColorAsset(name: "Sky_700")
    public static let sky800 = ColorAsset(name: "Sky_800")
    public static let sky900 = ColorAsset(name: "Sky_900")
    public static let violet10 = ColorAsset(name: "Violet_10")
    public static let violet100 = ColorAsset(name: "Violet_100")
    public static let violet150 = ColorAsset(name: "Violet_150")
    public static let violet200 = ColorAsset(name: "Violet_200")
    public static let violet300 = ColorAsset(name: "Violet_300")
    public static let violet400 = ColorAsset(name: "Violet_400")
    public static let violet50 = ColorAsset(name: "Violet_50")
    public static let violet600 = ColorAsset(name: "Violet_600")
    public static let violet700 = ColorAsset(name: "Violet_700")
    public static let violet800 = ColorAsset(name: "Violet_800")
    public static let violet900 = ColorAsset(name: "Violet_900")
    public static let white = ColorAsset(name: "White")
    public static let yellow10 = ColorAsset(name: "Yellow_10")
    public static let yellow100 = ColorAsset(name: "Yellow_100")
    public static let yellow150 = ColorAsset(name: "Yellow_150")
    public static let yellow200 = ColorAsset(name: "Yellow_200")
    public static let yellow300 = ColorAsset(name: "Yellow_300")
    public static let yellow400 = ColorAsset(name: "Yellow_400")
    public static let yellow50 = ColorAsset(name: "Yellow_50")
    public static let yellow500 = ColorAsset(name: "Yellow_500")
    public static let yellow600 = ColorAsset(name: "Yellow_600")
    public static let yellow700 = ColorAsset(name: "Yellow_700")
    public static let yellow800 = ColorAsset(name: "Yellow_800")
    public static let yellow900 = ColorAsset(name: "Yellow_900")
    public static let primary = ColorAsset(name: "primary")
  }
  public enum Images {
    public static let apartment = ImageAsset(name: "apartment")
    public static let factory = ImageAsset(name: "factory")
    public static let house = ImageAsset(name: "house")
    public static let land = ImageAsset(name: "land")
    public static let offictel = ImageAsset(name: "offictel")
    public static let store = ImageAsset(name: "store")
    public static let launchScreenMap = ImageAsset(name: "launchScreenMap")
    public static let logo = ImageAsset(name: "logo")
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
  public typealias Color = UIColor
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
  convenience init?(asset: ColorAsset) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
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

