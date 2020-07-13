//
//  AppReducer.swift
//  Redux
//
//  Created by Tamron Technology on 13/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    let searchState: SearchState
}

func appReducer(_ action: Action, _ state: AppState?) -> AppState{
    return AppState(searchState: searchReducer(action, state?.searchState) ?? SearchState(searchWords: []))
}
