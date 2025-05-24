// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum L10n {
  /// cancel
  public static let commonCancel = L10n.tr("Localizable", "common_cancel", fallback: "cancel")
  /// close
  public static let commonClose = L10n.tr("Localizable", "common_close", fallback: "close")
  /// confirm
  public static let commonConfirm = L10n.tr("Localizable", "common_confirm", fallback: "confirm")
  /// no
  public static let commonNo = L10n.tr("Localizable", "common_no", fallback: "no")
  /// yes
  public static let commonYes = L10n.tr("Localizable", "common_yes", fallback: "yes")
  /// Seoul Guanak-gu
  public static let homeDefaultArea = L10n.tr("Localizable", "home_default_area", fallback: "Seoul Guanak-gu")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}
