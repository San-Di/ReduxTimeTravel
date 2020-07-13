//
//  ViewController.swift
//  Redux
//
//  Created by Tamron Technology on 07/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblViewMovieList: UITableView!
    
    let viewModel = MovieListViewModel()
    let bag = DisposeBag()
    var movieList = [Movie]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchPopularMovies()
        bindData()
    }
    
    func bindData(){
        
        viewModel.movieListPublishRelay.subscribe(onNext: { (movieList) in
            self.movieList = movieList
            self.tblViewMovieList.reloadData()
        }).disposed(by: bag)
    }
    
    func setupUI(){
        searchBar.delegate = self
        tblViewMovieList.tableFooterView = UIView()
        tblViewMovieList.dataSource = self
        tblViewMovieList.delegate = self
        tblViewMovieList.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
        cell.data = movieList[indexPath.row]
        return cell
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchByMovieName(text: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        viewModel.fetchPopularMovies()
    }
}
