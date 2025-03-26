public struct AnyViewFactory<Route: Hashable>: ViewFactory {
  private let _makeView: (Route) -> AnyView

  public init<Factory: ViewFactory>(_ factory: Factory) where Factory.RouteType == Route {
    self._makeView = { route in
      AnyView(factory.makeView(route))  // ViewBuilder 호출 결과도 감쌈
    }
  }

  public func makeView(_ route: Route) -> some View {
    _makeView(route) // 반환은 type-erased
  }
}