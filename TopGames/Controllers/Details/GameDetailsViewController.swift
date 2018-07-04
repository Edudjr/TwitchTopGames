//
//  GameDetailsViewController.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

/*
 * Ps: Apparently, the view count is not included in the new API anymore, check: https://discuss.dev.twitch.tv/t/number-of-views-per-game-for-new-api/14829
 */

import UIKit

class GameDetailsViewController: UIViewController {
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameViews: UILabel!
    
}
