//
//  HistoryViewController.swift
//  Redux
//
//  Created by Tamron Technology on 13/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import UIKit
import ReSwift

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!{
        didSet{
            slider.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        }
    }
    @IBOutlet weak var tblViewHistoryList: UITableView!
    
    var mMovieList = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        store.dispatch(SearchAction.fetchAllSearch)
    }
    
    func setupUI(){
        slider.value = 0
        slider.isContinuous = false
        tblViewHistoryList.tableFooterView = UIView()
        tblViewHistoryList.dataSource = self
        tblViewHistoryList.register(UINib(nibName: String(describing: MovieTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieTableViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        store.subscribe(self){
            $0.select {
                $0.searchState
            }
        }
    }
    
    @IBAction func onSliderValueChange(_ sender: Any) {
        
    }
}

extension HistoryViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mMovieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieTableViewCell.self), for: indexPath) as! MovieTableViewCell
        cell.data = mMovieList[indexPath.row]
        return cell
        
    }
    
}

extension HistoryViewController: StoreSubscriber{
    func newState(state: SearchState) {
        
        slider.maximumValue = Float(state.searchWords.count)
        self.mMovieList = state.searchWords.last?.resultList ?? []
        self.tblViewHistoryList.reloadData()
        
    }
}

