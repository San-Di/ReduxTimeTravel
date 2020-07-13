//
//  Action.swift
//  Redux
//
//  Created by Tamron Technology on 13/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import ReSwift

enum SearchAction: Action{
    case addNewSearch(SearchWords)
    case fetchSearch(_ keyword: String)
    case fetchAllSearch
    
}
