//
//  DetailPostTableViewCell.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit

class DetailPostTableViewCell: UITableViewCell {
    
    //MARKS: Variable & Outlets
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setup(comment: Comment) {
        self.commentLabel.text = comment.body
    }

}
