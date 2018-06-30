//
//  GameItemColletionViewCell.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 28/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

protocol GameItemCellDelegate {
    func clickToAddFavoriteGame(gameId: Int)
    func clickToRemoveFavoriteGame(gameId: Int)
}

class GameItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!  
    @IBOutlet weak var gameImage: UIImageView!
    var id: Int?
    var delegate: GameItemCellDelegate?
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            button.isSelected = !button.isSelected
            
            guard let id = id else { return }
            if button.isSelected {
                delegate?.clickToAddFavoriteGame(gameId: id)
            } else {
                delegate?.clickToRemoveFavoriteGame(gameId: id)
            }
        }
    }
}
