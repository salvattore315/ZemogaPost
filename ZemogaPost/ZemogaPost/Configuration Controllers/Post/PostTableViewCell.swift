//
//  PostTableViewCell.swift
//  ZemogaPost
//
//  Created by Salvador Martinez on 12/12/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    //MARKS: Variable & Outlets
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var circleBlueImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setup(post: Post, index: Int) {
        self.postLabel.text = post.title
        //self.favoriteImageView.isHidden = !(post.internalInformation.isFavorite.value)
        if(index < 20){
          //  self.circleBlueImageView.isHidden = post.internalInformation.isRead.value
        } else {
            self.circleBlueImageView.isHidden = true
        }
    }
}
