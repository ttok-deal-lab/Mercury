import SwiftUI

import Domain
import Router
import Report

/// 로그인·서버 없이 임장크루 화면 흐름(목록 → 크루장 신청 → 프로필 작성 → 완료) 을 확인하는 샘플 앱.
@main
struct ReportSampleApp: App {
  @StateObject private var coordinator = NavigationCoordinator<FeatureRoute>()
  
  var body: some Scene {
    WindowGroup {
      NavigationStack(path: $coordinator.rootStack) {
        ReportView(crewLeaderUsecase: SampleCrewLeaderUsecase())
          .navigationDestination(for: FeatureRoute.self) { route in
            if case .report(let reportRoute) = route {
              ReportViewFactory().makeView(reportRoute)
            } else {
              EmptyView()
            }
          }
      }
      .environmentObject(coordinator)
    }
  }
}
