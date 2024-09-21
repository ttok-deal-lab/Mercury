//
//  TestReducer.swift
//  DataSampleApp
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import ComposableArchitecture
import Combine
import SwiftyJSON
import Network

@Reducer
struct TestReducer {
  
  @ObservableState
  struct State {
    var apiResult: String
    
    init(apiResult: String) {
      self.apiResult = apiResult
    }
  }
  
  enum Action {
    case testAPI
    case testAPIResponse(String)
    case error(Error)
  }
  
  private var cancellables = Set<AnyCancellable>()
  
  var body: some ReducerOf<Self> {
    
    Reduce { state, action in
      switch action {
      case .testAPI:
        let networkManager = NetworkManager<MockAPI>()
        return .run { send in
          let result = await networkManager.request(target: .mockingAPI)
          switch result {
          case .success(let data):
            if let setupString = JSON(data)["setup"].string {
              await send(.testAPIResponse(setupString))
            }
          case .failure(let error):
            await send(.error(error))
          }
        }
        
      case .testAPIResponse(let resultString):
        state.apiResult = resultString
        return .none
      case .error(_):
        return .none
      }
    }
  }
}