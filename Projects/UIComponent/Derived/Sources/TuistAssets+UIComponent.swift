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
    public static let shadow = ColorAsset(name: "Shadow")
    public static let textBlack = ColorAsset(name: "TextBlack")
    public static let textDefault = ColorAsset(name: "TextDefault")
    public static let textDisabled = ColorAsset(name: "TextDisabled")
    public static let textError = ColorAsset(name: "TextError")
    public static let textSubText = ColorAsset(name: "TextSubText")
    public static let textSuccess = ColorAsset(name: "TextSuccess")
    public static let textWhite = ColorAsset(name: "TextWhite")
  }
  public enum Images {
    public static let updown = ImageAsset(name: "Updown")
    public static let arrowDownNoShaft = ImageAsset(name: "arrow-down-no-shaft")
    public static let arrowDown = ImageAsset(name: "arrow-down")
    public static let arrowLeftNoShaft = ImageAsset(name: "arrow-left-no-shaft")
    public static let arrowLeft = ImageAsset(name: "arrow-left")
    public static let arrowRightNoShaft = ImageAsset(name: "arrow-right-no-shaft")
    public static let arrowRight = ImageAsset(name: "arrow-right")
    public static let arrowUpNoShaft = ImageAsset(name: "arrow-up-no-shaft")
    public static let arrowUp = ImageAsset(name: "arrow-up")
    public static let chevronUp = ImageAsset(name: "chevron_Up")
    public static let chevronDown = ImageAsset(name: "chevron_down")
    public static let chevronLeft = ImageAsset(name: "chevron_left")
    public static let chevronRight = ImageAsset(name: "chevron_right")
    public static let closePassword = ImageAsset(name: "close-password")
    public static let close = ImageAsset(name: "close")
    public static let edit = ImageAsset(name: "edit")
    public static let minus = ImageAsset(name: "minus")
    public static let plus = ImageAsset(name: "plus")
    public static let roundPlus = ImageAsset(name: "round_plus")
    public static let addPhoto = ImageAsset(name: "Add photo")
    public static let bellFillDot = ImageAsset(name: "Bell-fill-dot")
    public static let bellFill = ImageAsset(name: "Bell-fill")
    public static let build = ImageAsset(name: "Build")
    public static let call = ImageAsset(name: "Call")
    public static let camera = ImageAsset(name: "Camera")
    public static let charge = ImageAsset(name: "Charge")
    public static let check = ImageAsset(name: "Check")
    public static let clock = ImageAsset(name: "Clock")
    public static let coin = ImageAsset(name: "Coin")
    public static let coupon = ImageAsset(name: "Coupon")
    public static let danger = ImageAsset(name: "Danger")
    public static let delete = ImageAsset(name: "Delete")
    public static let edit2 = ImageAsset(name: "Edit-2")
    public static let filter = ImageAsset(name: "Filter")
    public static let graph = ImageAsset(name: "Graph")
    public static let invisible = ImageAsset(name: "Invisible")
    public static let location = ImageAsset(name: "Location")
    public static let mapFill = ImageAsset(name: "Map-fill")
    public static let noti = ImageAsset(name: "Noti")
    public static let parking = ImageAsset(name: "Parking")
    public static let person = ImageAsset(name: "Person")
    public static let placeTime = ImageAsset(name: "Place-time")
    public static let place = ImageAsset(name: "Place")
    public static let starHalf = ImageAsset(name: "Star-Half")
    public static let star = ImageAsset(name: "Star")
    public static let visible = ImageAsset(name: "Visible")
    public static let warning = ImageAsset(name: "Warning")
    public static let calendar1 = ImageAsset(name: "calendar1")
    public static let calendar2 = ImageAsset(name: "calendar2")
    public static let gallery = ImageAsset(name: "gallery")
    public static let heart = ImageAsset(name: "heart")
    public static let homeOff = ImageAsset(name: "home-off")
    public static let homeOn = ImageAsset(name: "home-on")
    public static let reportOff = ImageAsset(name: "report-off")
    public static let reportOn = ImageAsset(name: "report-on")
    public static let infoFill = ImageAsset(name: "Info-fill")
    public static let infoLine = ImageAsset(name: "Info-line")
    public static let questionFill = ImageAsset(name: "Question-fill")
    public static let questionLine = ImageAsset(name: "Question-line")
    public static let sucessFill = ImageAsset(name: "Sucess-fill")
    public static let sucessLine = ImageAsset(name: "Sucess-line")
    public static let download = ImageAsset(name: "Download")
    public static let edit1 = ImageAsset(name: "Edit-1")
    public static let expand = ImageAsset(name: "Expand")
    public static let export = ImageAsset(name: "Export")
    public static let filter3dot = ImageAsset(name: "Filter-3dot")
    public static let info = ImageAsset(name: "Info")
    public static let loading = ImageAsset(name: "Loading")
    public static let menuH = ImageAsset(name: "Menu-h")
    public static let notification = ImageAsset(name: "Notification")
    public static let placeLocation = ImageAsset(name: "Place-location")
    public static let redo = ImageAsset(name: "Redo")
    public static let reduce = ImageAsset(name: "Reduce")
    public static let search = ImageAsset(name: "Search")
    public static let settingFill = ImageAsset(name: "Setting-fill")
    public static let setting = ImageAsset(name: "Setting")
    public static let undo = ImageAsset(name: "Undo")
    public static let listThreeLine = ImageAsset(name: "list_three_line")
    public static let listTwoLine = ImageAsset(name: "list_two_line")
    public static let qnA1 = ImageAsset(name: "QnA-1")
    public static let qnA2 = ImageAsset(name: "QnA-2")
    public static let card = ImageAsset(name: "card")
    public static let coupone = ImageAsset(name: "coupone")
    public static let event = ImageAsset(name: "event")
    public static let government = ImageAsset(name: "government")
    public static let inquire = ImageAsset(name: "inquire")
    public static let manageCard = ImageAsset(name: "manage-card")
    public static let notice = ImageAsset(name: "notice")
    public static let report = ImageAsset(name: "report")
    public static let requestUpdate = ImageAsset(name: "request-update")
    public static let creditCard = ImageAsset(name: "CreditCard")
    public static let lpay = ImageAsset(name: "Lpay")
    public static let naverPay1 = ImageAsset(name: "NaverPay-1")
    public static let naverPay2 = ImageAsset(name: "NaverPay-2")
    public static let payco = ImageAsset(name: "Payco")
    public static let apple = ImageAsset(name: "Apple")
    public static let google = ImageAsset(name: "Google")
    public static let kakao = ImageAsset(name: "Kakao")
    public static let naver = ImageAsset(name: "Naver")
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

