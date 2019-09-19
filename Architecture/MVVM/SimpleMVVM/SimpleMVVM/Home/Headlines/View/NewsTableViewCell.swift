//
//  NewsTableViewCell.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    var articleViewModel: ArticleViewModel! {
        didSet {
            TitleLabel.text = articleViewModel.title
            subTitleLabel.text = articleViewModel.description
            infoLabel.text = articleViewModel.info
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
