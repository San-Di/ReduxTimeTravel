//
//  MovieTableViewCell.swift
//  Redux
//
//  Created by Sandi on 7/12/20.
//  Copyright © 2020 Zenness Evolutionary. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovieName: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblVotePercentage: UILabel!
    
    var data: Movie?{
        didSet{
            if let movie = data{
                imgMovieName.sd_setImage(with: URL(string: "\(BASE_IMG_URL)\(movie.posterPath)" )?.absoluteURL, completed: nil)
                lblMovieName.text = movie.title
                lblDate.text = movie.releaseDate
                lblDescription.text = movie.overview
                lblVotePercentage.text = "\(movie.voteAverage * 10)%"
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle  = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
