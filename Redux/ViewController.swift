//
//  ViewController.swift
//  Redux
//
//  Created by Tamron Technology on 07/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblViewMovieList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI(){
        tblViewMovieList.dataSource = self
        tblViewMovieList.delegate = self
        tblViewMovieList.register(UINib(nibName: String(describing: MovieItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MovieItemTableViewCell.self))
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieItemTableViewCell.self), for: indexPath) as! MovieItemTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 380
    }
}

