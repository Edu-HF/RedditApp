//
//  NewsTableViewCell.swift
//  RedditApp
//
//  Created by Eduardo on 2/3/17.
//  Copyright © 2017 Eduardo Herrera. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var cellThumbnail: UIImageView!
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellAuthor: UILabel!
    @IBOutlet var cellDate: UILabel!
    @IBOutlet var cellCommentsNum: UILabel!
    @IBOutlet var cellFacebookButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
