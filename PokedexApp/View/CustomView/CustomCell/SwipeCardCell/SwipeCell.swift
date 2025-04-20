//
//  SwipeCell.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 19/04/25.
//

import UIKit

class SwipeCell: UICollectionViewCell {
    
    @IBOutlet weak var swBackgroundView: UIView!
    @IBOutlet weak var swCardImage: UIImageView!
    @IBOutlet weak var swTitleLabel: UILabel!
    @IBOutlet weak var swIdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        swBackgroundView.layer.cornerRadius = 40
        swIdLabel?.layer.masksToBounds = true
        swIdLabel?.layer.cornerRadius = 16
        swCardImage?.layer.cornerRadius = 30
        swCardImage?.clipsToBounds = true
    }
}
