//
//  QuestionGroupCell.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 29/05/20.
//  Copyright © 2020 Bhavesh Tandel. All rights reserved.
//

import UIKit
import Combine

class QuestionGroupCell: UITableViewCell {
    @IBOutlet public var titleLabel: UILabel!
    @IBOutlet public var percentageLabel: UILabel!
    public var percentageSubscriber: AnyCancellable?
    
}
