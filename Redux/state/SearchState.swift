//
//  SearchState.swift
//  Redux
//
//  Created by Tamron Technology on 13/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation

struct SearchState {
    var searchWords: [SearchWords]
    
    init(searchWords: [SearchWords]) {
        self.searchWords = searchWords
    }
}



