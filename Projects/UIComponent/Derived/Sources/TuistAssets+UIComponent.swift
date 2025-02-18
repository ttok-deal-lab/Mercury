// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

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

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum UIComponentAsset {
  public enum Colors {
  public static let black = UIComponentColors(name: "Black")
    public static let blue10 = UIComponentColors(name: "Blue_10")
    public static let blue100 = UIComponentColors(name: "Blue_100")
    public static let blue150 = UIComponentColors(name: "Blue_150")
    public static let blue200 = UIComponentColors(name: "Blue_200")
    public static let blue300 = UIComponentColors(name: "Blue_300")
    public static let blue400 = UIComponentColors(name: "Blue_400")
    public static let blue50 = UIComponentColors(name: "Blue_50")
    public static let blue600 = UIComponentColors(name: "Blue_600")
    public static let blue700 = UIComponentColors(name: "Blue_700")
    public static let blue800 = UIComponentColors(name: "Blue_800")
    public static let blue900 = UIComponentColors(name: "Blue_900")
    public static let dim = UIComponentColors(name: "Dim")
    public static let gray10 = UIComponentColors(name: "Gray_10")
    public static let gray100 = UIComponentColors(name: "Gray_100")
    public static let gray20 = UIComponentColors(name: "Gray_20")
    public static let gray200 = UIComponentColors(name: "Gray_200")
    public static let gray30 = UIComponentColors(name: "Gray_30")
    public static let gray300 = UIComponentColors(name: "Gray_300")
    public static let gray40 = UIComponentColors(name: "Gray_40")
    public static let gray400 = UIComponentColors(name: "Gray_400")
    public static let gray50 = UIComponentColors(name: "Gray_50")
    public static let gray500 = UIComponentColors(name: "Gray_500")
    public static let gray60 = UIComponentColors(name: "Gray_60")
    public static let gray600 = UIComponentColors(name: "Gray_600")
    public static let gray70 = UIComponentColors(name: "Gray_70")
    public static let gray700 = UIComponentColors(name: "Gray_700")
    public static let gray80 = UIComponentColors(name: "Gray_80")
    public static let gray800 = UIComponentColors(name: "Gray_800")
    public static let gray90 = UIComponentColors(name: "Gray_90")
    public static let green10 = UIComponentColors(name: "Green_10")
    public static let green100 = UIComponentColors(name: "Green_100")
    public static let green150 = UIComponentColors(name: "Green_150")
    public static let green200 = UIComponentColors(name: "Green_200")
    public static let green300 = UIComponentColors(name: "Green_300")
    public static let green400 = UIComponentColors(name: "Green_400")
    public static let green50 = UIComponentColors(name: "Green_50")
    public static let green500 = UIComponentColors(name: "Green_500")
    public static let green600 = UIComponentColors(name: "Green_600")
    public static let green700 = UIComponentColors(name: "Green_700")
    public static let green800 = UIComponentColors(name: "Green_800")
    public static let green900 = UIComponentColors(name: "Green_900")
    public static let lightBlue10 = UIComponentColors(name: "Light Blue_10")
    public static let lightBlue100 = UIComponentColors(name: "Light Blue_100")
    public static let lightBlue150 = UIComponentColors(name: "Light Blue_150")
    public static let lightBlue200 = UIComponentColors(name: "Light Blue_200")
    public static let lightBlue300 = UIComponentColors(name: "Light Blue_300")
    public static let lightBlue400 = UIComponentColors(name: "Light Blue_400")
    public static let lightBlue50 = UIComponentColors(name: "Light Blue_50")
    public static let lightBlue500 = UIComponentColors(name: "Light Blue_500")
    public static let lightBlue600 = UIComponentColors(name: "Light Blue_600")
    public static let lightBlue700 = UIComponentColors(name: "Light Blue_700")
    public static let lightBlue800 = UIComponentColors(name: "Light Blue_800")
    public static let lightBlue900 = UIComponentColors(name: "Light Blue_900")
    public static let mainBlue500 = UIComponentColors(name: "Main Blue_500")
    public static let mainViolet500 = UIComponentColors(name: "Main Violet_500")
    public static let mint10 = UIComponentColors(name: "Mint_10")
    public static let mint100 = UIComponentColors(name: "Mint_100")
    public static let mint150 = UIComponentColors(name: "Mint_150")
    public static let mint200 = UIComponentColors(name: "Mint_200")
    public static let mint300 = UIComponentColors(name: "Mint_300")
    public static let mint400 = UIComponentColors(name: "Mint_400")
    public static let mint50 = UIComponentColors(name: "Mint_50")
    public static let mint500 = UIComponentColors(name: "Mint_500")
    public static let mint600 = UIComponentColors(name: "Mint_600")
    public static let mint700 = UIComponentColors(name: "Mint_700")
    public static let mint800 = UIComponentColors(name: "Mint_800")
    public static let mint900 = UIComponentColors(name: "Mint_900")
    public static let orange10 = UIComponentColors(name: "Orange_10")
    public static let orange100 = UIComponentColors(name: "Orange_100")
    public static let orange150 = UIComponentColors(name: "Orange_150")
    public static let orange200 = UIComponentColors(name: "Orange_200")
    public static let orange300 = UIComponentColors(name: "Orange_300")
    public static let orange400 = UIComponentColors(name: "Orange_400")
    public static let orange50 = UIComponentColors(name: "Orange_50")
    public static let orange500 = UIComponentColors(name: "Orange_500")
    public static let orange600 = UIComponentColors(name: "Orange_600")
    public static let orange700 = UIComponentColors(name: "Orange_700")
    public static let orange800 = UIComponentColors(name: "Orange_800")
    public static let orange900 = UIComponentColors(name: "Orange_900")
    public static let pink10 = UIComponentColors(name: "Pink_10")
    public static let pink100 = UIComponentColors(name: "Pink_100")
    public static let pink150 = UIComponentColors(name: "Pink_150")
    public static let pink200 = UIComponentColors(name: "Pink_200")
    public static let pink300 = UIComponentColors(name: "Pink_300")
    public static let pink400 = UIComponentColors(name: "Pink_400")
    public static let pink50 = UIComponentColors(name: "Pink_50")
    public static let pink500 = UIComponentColors(name: "Pink_500")
    public static let pink600 = UIComponentColors(name: "Pink_600")
    public static let pink700 = UIComponentColors(name: "Pink_700")
    public static let pink800 = UIComponentColors(name: "Pink_800")
    public static let pink900 = UIComponentColors(name: "Pink_900")
    public static let pistachio10 = UIComponentColors(name: "Pistachio_10")
    public static let pistachio100 = UIComponentColors(name: "Pistachio_100")
    public static let pistachio150 = UIComponentColors(name: "Pistachio_150")
    public static let pistachio200 = UIComponentColors(name: "Pistachio_200")
    public static let pistachio300 = UIComponentColors(name: "Pistachio_300")
    public static let pistachio400 = UIComponentColors(name: "Pistachio_400")
    public static let pistachio50 = UIComponentColors(name: "Pistachio_50")
    public static let pistachio500 = UIComponentColors(name: "Pistachio_500")
    public static let pistachio600 = UIComponentColors(name: "Pistachio_600")
    public static let pistachio700 = UIComponentColors(name: "Pistachio_700")
    public static let pistachio800 = UIComponentColors(name: "Pistachio_800")
    public static let pistachio900 = UIComponentColors(name: "Pistachio_900")
    public static let red10 = UIComponentColors(name: "Red_10")
    public static let red100 = UIComponentColors(name: "Red_100")
    public static let red150 = UIComponentColors(name: "Red_150")
    public static let red200 = UIComponentColors(name: "Red_200")
    public static let red300 = UIComponentColors(name: "Red_300")
    public static let red400 = UIComponentColors(name: "Red_400")
    public static let red50 = UIComponentColors(name: "Red_50")
    public static let red500 = UIComponentColors(name: "Red_500")
    public static let red600 = UIComponentColors(name: "Red_600")
    public static let red700 = UIComponentColors(name: "Red_700")
    public static let red800 = UIComponentColors(name: "Red_800")
    public static let red900 = UIComponentColors(name: "Red_900")
    public static let salmon10 = UIComponentColors(name: "Salmon_10")
    public static let salmon100 = UIComponentColors(name: "Salmon_100")
    public static let salmon150 = UIComponentColors(name: "Salmon_150")
    public static let salmon200 = UIComponentColors(name: "Salmon_200")
    public static let salmon300 = UIComponentColors(name: "Salmon_300")
    public static let salmon400 = UIComponentColors(name: "Salmon_400")
    public static let salmon50 = UIComponentColors(name: "Salmon_50")
    public static let salmon500 = UIComponentColors(name: "Salmon_500")
    public static let salmon600 = UIComponentColors(name: "Salmon_600")
    public static let salmon700 = UIComponentColors(name: "Salmon_700")
    public static let salmon800 = UIComponentColors(name: "Salmon_800")
    public static let salmon900 = UIComponentColors(name: "Salmon_900")
    public static let sky10 = UIComponentColors(name: "Sky_10")
    public static let sky100 = UIComponentColors(name: "Sky_100")
    public static let sky150 = UIComponentColors(name: "Sky_150")
    public static let sky200 = UIComponentColors(name: "Sky_200")
    public static let sky300 = UIComponentColors(name: "Sky_300")
    public static let sky400 = UIComponentColors(name: "Sky_400")
    public static let sky50 = UIComponentColors(name: "Sky_50")
    public static let sky500 = UIComponentColors(name: "Sky_500")
    public static let sky600 = UIComponentColors(name: "Sky_600")
    public static let sky700 = UIComponentColors(name: "Sky_700")
    public static let sky800 = UIComponentColors(name: "Sky_800")
    public static let sky900 = UIComponentColors(name: "Sky_900")
    public static let violet10 = UIComponentColors(name: "Violet_10")
    public static let violet100 = UIComponentColors(name: "Violet_100")
    public static let violet150 = UIComponentColors(name: "Violet_150")
    public static let violet200 = UIComponentColors(name: "Violet_200")
    public static let violet300 = UIComponentColors(name: "Violet_300")
    public static let violet400 = UIComponentColors(name: "Violet_400")
    public static let violet50 = UIComponentColors(name: "Violet_50")
    public static let violet600 = UIComponentColors(name: "Violet_600")
    public static let violet700 = UIComponentColors(name: "Violet_700")
    public static let violet800 = UIComponentColors(name: "Violet_800")
    public static let violet900 = UIComponentColors(name: "Violet_900")
    public static let white = UIComponentColors(name: "White")
    public static let yellow10 = UIComponentColors(name: "Yellow_10")
    public static let yellow100 = UIComponentColors(name: "Yellow_100")
    public static let yellow150 = UIComponentColors(name: "Yellow_150")
    public static let yellow200 = UIComponentColors(name: "Yellow_200")
    public static let yellow300 = UIComponentColors(name: "Yellow_300")
    public static let yellow400 = UIComponentColors(name: "Yellow_400")
    public static let yellow50 = UIComponentColors(name: "Yellow_50")
    public static let yellow500 = UIComponentColors(name: "Yellow_500")
    public static let yellow600 = UIComponentColors(name: "Yellow_600")
    public static let yellow700 = UIComponentColors(name: "Yellow_700")
    public static let yellow800 = UIComponentColors(name: "Yellow_800")
    public static let yellow900 = UIComponentColors(name: "Yellow_900")
    public static let primary = UIComponentColors(name: "primary")
  }
  public enum Images {
  public static let apartment = UIComponentImages(name: "apartment")
    public static let factory = UIComponentImages(name: "factory")
    public static let house = UIComponentImages(name: "house")
    public static let land = UIComponentImages(name: "land")
    public static let offictel = UIComponentImages(name: "offictel")
    public static let store = UIComponentImages(name: "store")
    public static let launchScreenMap = UIComponentImages(name: "launchScreenMap")
    public static let logo = UIComponentImages(name: "logo")
    public static let smililingKiss = UIComponentImages(name: "smililingKiss")
    public static let sunglasses = UIComponentImages(name: "sunglasses")
    public static let thinking = UIComponentImages(name: "thinking")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class UIComponentColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension UIComponentColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: UIComponentColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: UIComponentColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct UIComponentImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: UIComponentImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: UIComponentImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: UIComponentImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
