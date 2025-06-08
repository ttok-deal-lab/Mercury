struct PressableBackgroundStyle: ButtonStyle {
  var normalColor: Color = .clear
  var pressedColor: Color = Color.gray.opacity(0.1)

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? pressedColor : normalColor)
  }
}