//
//  GameItemColletionViewCell.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 28/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class GameItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!  
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isSelected = !button.isSelected
        }
    }
}
