//
//  movieCell.swift
//  Demo_Movie
//
//  Created by Vimal on 19/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import UIKit

class movieCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    
    var movie:Movie? {
        didSet {
            configureDisplay()
        }
    }
    
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
    }
    
    func configureDisplay() {
        if let movieObject = movie {
            
            lblTitle.text = movieObject.title ?? "No Title Available"
            lblDate.text = movieObject.releaseDate ?? "Date not Available"
            if let rating = movieObject.rating {
                lblRating.text = "Rating : \(rating)"
            }else{
                 lblRating.text = "Rating : Not Available"
            }
            lblContent.text = movieObject.overview  ?? "No overview is Available at the moment"
            self.downloadPoster()
            
        }
    }
    
    
    func downloadPoster()  {
        if let imgUrl = movie?.posterUrlString, !imgUrl.isEmpty {
            print("image url is \(imgUrl)")
            downloadImage(from: imgUrl) { (image) in
                print("downloadImage done")
                if let imageFound = image {
                    DispatchQueue.main.async {
                        self.imgMovie.image = imageFound
                    }
                }
            }
        }
    }
   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
