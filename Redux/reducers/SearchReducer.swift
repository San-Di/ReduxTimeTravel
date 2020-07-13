//
//  SearchReducer.swift
//  Redux
//
//  Created by Tamron Technology on 13/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import ReSwift

func searchReducer(_ action: Action, _ state: SearchState?) -> SearchState? {
    
    var initialState = state
    guard let action = action as? SearchAction else {
        return nil
    }
    switch action {
        
    case .addNewSearch(let searchWord):
        let newWord = SearchWords(keyword: searchWord.keyword, resultList: searchWord.resultList)
        initialState?.searchWords.append(newWord)
        return initialState
        
        
    case .fetchSearch(let keyword):
        let fetchWord = initialState?.searchWords.filter { (searchWord) in
            return searchWord.keyword == keyword
            } ?? []
        return SearchState(searchWords: fetchWord)
        
    case .fetchAllSearch:
        return initialState
    }
}
