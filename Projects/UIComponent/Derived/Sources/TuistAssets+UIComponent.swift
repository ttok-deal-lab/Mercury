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
    public static let gray10BackgroundDefault = ColorAsset(name: "Gray10BackgroundDefault")
    public static let gray50BackgroundMuted = ColorAsset(name: "Gray50BackgroundMuted")
    public static let gray100BorderDefault = ColorAsset(name: "Gray100BorderDefault")
    public static let gray200BorderDark = ColorAsset(name: "Gray200BorderDark")
    public static let primary200BorderSuccess = ColorAsset(name: "Primary200BorderSuccess")
    public static let red700BorderError = ColorAsset(name: "Red700BorderError")
    public static let gray200ButtonBlackDisabled = ColorAsset(name: "Gray200ButtonBlackDisabled")
    public static let gray700ButtonBlackDefault = ColorAsset(name: "Gray700ButtonBlackDefault")
    public static let gray800ButtonBlackPressed = ColorAsset(name: "Gray800ButtonBlackPressed")
    public static let gray150 = ColorAsset(name: "Gray150")
    public static let gray200ButtonGrayDisabled = ColorAsset(name: "Gray200ButtonGrayDisabled")
    public static let gray300ButtonGrayPressed = ColorAsset(name: "Gray300ButtonGrayPressed")
    public static let gray600 = ColorAsset(name: "Gray600")
    public static let shadow = ColorAsset(name: "Shadow")
    public static let gray300TextDisabled = ColorAsset(name: "Gray300TextDisabled")
    public static let primary200TextSuccess = ColorAsset(name: "Primary200TextSuccess")
    public static let red700TextError = ColorAsset(name: "Red700TextError")
    public static let primary = ColorAsset(name: "Primary")
    public static let primaryContrast = ColorAsset(name: "PrimaryContrast")
    public static let primaryLight = ColorAsset(name: "PrimaryLight")
    public static let primaryMuted = ColorAsset(name: "PrimaryMuted")
    public static let primaryWeak = ColorAsset(name: "PrimaryWeak")
    public static let neutral = ColorAsset(name: "Neutral")
    public static let neutralContrast = ColorAsset(name: "NeutralContrast")
    public static let neutralLight = ColorAsset(name: "NeutralLight")
    public static let neutralMuted = ColorAsset(name: "NeutralMuted")
    public static let neutralSubtle = ColorAsset(name: "NeutralSubtle")
    public static let neutralSubtler = ColorAsset(name: "NeutralSubtler")
    public static let neutralWeak = ColorAsset(name: "NeutralWeak")
    public static let neutralWhite = ColorAsset(name: "NeutralWhite")
    public static let positive = ColorAsset(name: "Positive")
    public static let positiveLight = ColorAsset(name: "PositiveLight")
    public static let warning = ColorAsset(name: "Warning")
    public static let warningLight = ColorAsset(name: "WarningLight")
    public static let critical = ColorAsset(name: "Critical")
    public static let criticalLight = ColorAsset(name: "CriticalLight")
    public static let criticalSubtle = ColorAsset(name: "CriticalSubtle")
    public static let criticalWeak = ColorAsset(name: "CriticalWeak")
    public static let commonGradientEnd = ColorAsset(name: "CommonGradientEnd")
    public static let commonGradientStart = ColorAsset(name: "CommonGradientStart")
  }
  public enum Images {
    public static let chevronUp = ImageAsset(name: "Chevron_Up")
    public static let chevronDown = ImageAsset(name: "Chevron_down")
    public static let chevronLeft = ImageAsset(name: "Chevron_left")
    public static let chevronRight = ImageAsset(name: "Chevron_right")
    public static let updown = ImageAsset(name: "Updown")
    public static let arrowDownNoShaft = ImageAsset(name: "arrow-down-no-shaft")
    public static let arrowDown = ImageAsset(name: "arrow-down")
    public static let arrowLeftNoShaft = ImageAsset(name: "arrow-left-no-shaft")
    public static let arrowLeft = ImageAsset(name: "arrow-left")
    public static let arrowRightNoShaftGray = ImageAsset(name: "arrow-right-no-shaft-gray")
    public static let arrowRightNoShaft = ImageAsset(name: "arrow-right-no-shaft")
    public static let arrowRight = ImageAsset(name: "arrow-right")
    public static let arrowUpNoShaft = ImageAsset(name: "arrow-up-no-shaft")
    public static let arrowUp = ImageAsset(name: "arrow-up")
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
    public static let clock = ImageAsset(name: "Clock")
    public static let coin = ImageAsset(name: "Coin")
    public static let copy = ImageAsset(name: "Copy")
    public static let coupon = ImageAsset(name: "Coupon")
    public static let danger = ImageAsset(name: "Danger")
    public static let delete = ImageAsset(name: "Delete")
    public static let edit2 = ImageAsset(name: "Edit-2")
    public static let filter = ImageAsset(name: "Filter")
    public static let graph = ImageAsset(name: "Graph")
    public static let invisible = ImageAsset(name: "Invisible")
    public static let listNone = ImageAsset(name: "ListNone")
    public static let location = ImageAsset(name: "Location")
    public static let mapFill = ImageAsset(name: "Map-fill")
    public static let noti = ImageAsset(name: "Noti")
    public static let parking = ImageAsset(name: "Parking")
    public static let person = ImageAsset(name: "Person")
    public static let placeTime = ImageAsset(name: "Place-time")
    public static let place = ImageAsset(name: "Place")
    public static let share = ImageAsset(name: "Share")
    public static let starHalf = ImageAsset(name: "Star-Half")
    public static let star = ImageAsset(name: "Star")
    public static let visible = ImageAsset(name: "Visible")
    public static let warning = ImageAsset(name: "Warning")
    public static let calendar1 = ImageAsset(name: "calendar1")
    public static let calendar2 = ImageAsset(name: "calendar2")
    public static let certified = ImageAsset(name: "certified")
    public static let gallery = ImageAsset(name: "gallery")
    public static let heart = ImageAsset(name: "heart")
    public static let toastCommon = ImageAsset(name: "toast_common")
    public static let toastUrgent = ImageAsset(name: "toast_urgent")
    public static let gnbHome = ImageAsset(name: "GNB_home")
    public static let gnbHomeGray = ImageAsset(name: "GNB_home_gray")
    public static let gnbInterest = ImageAsset(name: "GNB_interest")
    public static let gnbInterestGray = ImageAsset(name: "GNB_interest_gray")
    public static let gnbMypage = ImageAsset(name: "GNB_mypage")
    public static let gnbMypageGray = ImageAsset(name: "GNB_mypage_gray")
    public static let gnbReport = ImageAsset(name: "GNB_report")
    public static let gnbReportGray = ImageAsset(name: "GNB_report_gray")
    public static let infoFill = ImageAsset(name: "Info-fill")
    public static let infoLine = ImageAsset(name: "Info-line")
    public static let questionFill = ImageAsset(name: "Question-fill")
    public static let questionLine = ImageAsset(name: "Question-line")
    public static let sucessFill = ImageAsset(name: "Sucess-fill")
    public static let sucessLine = ImageAsset(name: "Sucess-line")
    public static let chat = ImageAsset(name: "Chat")
    public static let download = ImageAsset(name: "Download")
    public static let edit1 = ImageAsset(name: "Edit-1")
    public static let expand = ImageAsset(name: "Expand")
    public static let export = ImageAsset(name: "Export")
    public static let filter3dot = ImageAsset(name: "Filter-3dot")
    public static let home = ImageAsset(name: "Home")
    public static let info = ImageAsset(name: "Info")
    public static let loading = ImageAsset(name: "Loading")
    public static let menuH = ImageAsset(name: "Menu-h")
    public static let notification = ImageAsset(name: "Notification")
    public static let placeLocation = ImageAsset(name: "Place-location")
    public static let redo = ImageAsset(name: "Redo")
    public static let reduce = ImageAsset(name: "Reduce")
    public static let search = ImageAsset(name: "Search")
    public static let settingBlack = ImageAsset(name: "Setting-black")
    public static let settingFill = ImageAsset(name: "Setting-fill")
    public static let setting = ImageAsset(name: "Setting")
    public static let undo = ImageAsset(name: "Undo")
    public static let listThreeLine = ImageAsset(name: "list_three_line")
    public static let listTwoLine = ImageAsset(name: "list_two_line")
    public static let slugWithTitle = ImageAsset(name: "SlugWithTitle")
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
    public static let check = ImageAsset(name: "check")
    public static let radioCheck = ImageAsset(name: "radio_check")
    public static let radioMuted = ImageAsset(name: "radio_muted")
    public static let radioUncheck = ImageAsset(name: "radio_uncheck")
    public static let roundCheck = ImageAsset(name: "round_check")
    public static let roundMuted = ImageAsset(name: "round_muted")
    public static let roundUncheck = ImageAsset(name: "round_uncheck")
    public static let squareCheck = ImageAsset(name: "square_check")
    public static let squareMuted = ImageAsset(name: "square_muted")
    public static let squareUncheck = ImageAsset(name: "square_uncheck")
    public static let uncheck = ImageAsset(name: "uncheck")
    public static let apple = ImageAsset(name: "Apple")
    public static let appleLogo = ImageAsset(name: "AppleLogo")
    public static let google = ImageAsset(name: "Google")
    public static let googleLogo = ImageAsset(name: "GoogleLogo")
    public static let kakao = ImageAsset(name: "Kakao")
    public static let kakaoLogo = ImageAsset(name: "KakaoLogo")
    public static let naver = ImageAsset(name: "Naver")
    public static let naverLogo = ImageAsset(name: "NaverLogo")
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

