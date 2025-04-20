//
//  PokeCell.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 19/04/25.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var cellContainerview: UIView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellContainerView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
