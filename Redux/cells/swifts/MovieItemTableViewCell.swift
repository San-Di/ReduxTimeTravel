//
//  MovieItemTableViewCell.swift
//  Redux
//
//  Created by Tamron Technology on 07/07/2020.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import UIKit

class MovieItemTableViewCell: UITableViewCell {

    @IBOutlet weak var colViewMovieList: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        setupUI()
        // Configure the view for the selected state
    }
    
    func setupUI() {
        colViewMovieList.dataSource = self
        colViewMovieList.delegate = self
        colViewMovieList.register(UINib(nibName: String(describing: MovieItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MovieItemCollectionViewCell.self))
    }
}

extension MovieItemTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieItemCollectionViewCell.self), for: indexPath) as! MovieItemCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = CGFloat(190)
        let cellHeight = CGFloat(400)
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
