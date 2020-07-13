//
//  MovieListViewModel.swift
//  Redux
//
//  Created by Sandi on 7/12/20.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

class MovieListViewModel {
    let disposableBag = DisposeBag()
    let apiClient = ApiClient.shared
    
    let movieListPublishRelay = PublishRelay<[Movie]>()
    
    func fetchPopularMovies() {
        apiClient.request(url: baseUrl+"popular", method: .get, parameters: [API_KEY: apiKey], headers: [:]).flatMap({ (response) -> Observable<MovieListResponse?> in
            
            if let data = response as? Data, let movieList = data.decode(modelType: MovieListResponse.self){
                
                return Observable.just(movieList)
            }
            return Observable.just(nil)
            
        }).subscribe(onNext: { (data) in
            if let movieList = data?.results{
                self.movieListPublishRelay.accept(movieList)
            }
        }, onError: { (error) in
            print("Error >>>> \(error.localizedDescription)")
        }).disposed(by: disposableBag)
    }
    
    func searchByMovieName(text: String){
        apiClient.request(url: searchUrl, method: .get, parameters: [API_KEY: apiKey , query: text], headers: [:]).flatMap({ (response) -> Observable<MovieListResponse?> in
            
            if let data = response as? Data, let movieList = data.decode(modelType: MovieListResponse.self){
                
                return Observable.just(movieList)
            }
            return Observable.just(nil)
            
        }).subscribe(onNext: { (data) in
            if let movieList = data?.results{
                self.movieListPublishRelay.accept(movieList)
            }
        }, onError: { (error) in
            print("Error >>>> \(error.localizedDescription)")
        }).disposed(by: disposableBag)
    }
}
