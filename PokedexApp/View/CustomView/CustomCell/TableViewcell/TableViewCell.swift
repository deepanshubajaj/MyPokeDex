//
//  TableViewCell.swift
//  PokedexApp
//
//  Created by Deepanshu Bajaj on 19/04/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var favImageView: UIImageView!
    @IBOutlet weak var favIdLabel: UILabel!
    @IBOutlet weak var favNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
