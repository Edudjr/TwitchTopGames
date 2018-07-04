//
//  FavoriteButton.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

@IBDesignable
class FavoriteButton: UIButton {
    @IBInspectable var defaultImage: UIImage?
    @IBInspectable var selectedImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        setup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setup()
    }
    
    func setup() {
        setBackgroundImage(defaultImage, for: .normal)
        setBackgroundImage(selectedImage, for: .selected)
    }
}
