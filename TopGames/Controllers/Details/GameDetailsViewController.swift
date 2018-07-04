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
    @IBOutlet weak var gameUIImage: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var gameViews: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    var repository: GameRepositoryProtocol?
    var gameId: String?
    var gameTitle: String?
    var gameThumbnail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let gameId = gameId {
            fetchGame(gameId: gameId)
        }
    }
    
    private func fetchGame(gameId: String) {
        repository?.getGameViewsBy(id: gameId, completion: { (success, views) in
            if success, let views = views {
                self.updateViews(views: views)
            }
        })
    }
    
    private func setupView() {
        guard let title = gameTitle, let thumbnail = gameThumbnail else { return }
        self.title = title
        gameLabel.text = title
        gameUIImage.kf.setImage(with: URL(string: thumbnail), placeholder: #imageLiteral(resourceName: "placeholder"), options: nil, progressBlock: nil) { (image, error, cacheType, url) in
            let percentage = 100 - image!.size.width*100/self.view.frame.width
            let newHeight = image!.size.height*(percentage/100 + 1)
            self.imageHeight.constant = newHeight
        }
    }
    
    private func updateViews(views: Int) {
        gameViews.text = "\(views)"
    }
}
