//
//  CatalogViewController.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 28/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import Kingfisher

class CatalogViewController: UIViewController {
    var repository: RepositoryProtocol?
    var gamesModel = [RepositoryGameModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        setupCollectionViewCellSize()
        repository?.getMoreTopGames(completion: handleGetMoreTopGames)
    }
    
    private func setupCollectionViewCellSize(){
        let padding: CGFloat = 20.0
        let width = view.frame.width / 2 - padding
        let height = width * 1.2
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func findGameBy(id: Int) -> RepositoryGameModel? {
        return gamesModel.filter({ $0.id! == id}).first
    }
    
    private func handleGetMoreTopGames(success: Bool, games: [RepositoryGameModel]?) {
        if success, let games = games {
            self.gamesModel = games
        }
        //TODO: Alert for failure
    }
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCollectionViewCellIdentifier", for: indexPath) as? GameItemCollectionViewCell {
            let game = gamesModel[indexPath.row]
            cell.delegate = self
            cell.id = game.id
            cell.titleLabel.text = game.name
            cell.gameImage.kf.setImage(with: URL(string: game.thumbnail ?? ""), placeholder: #imageLiteral(resourceName: "placeholder"))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = gamesModel.count
        return count
    }
    
    //Infinite scroll
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = gamesModel.count
        if indexPath.row == count - 1 {
            repository?.getMoreTopGames(completion: handleGetMoreTopGames)
        }
    }
}

extension CatalogViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let padding: CGFloat = 40/3
        let inset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let padding: CGFloat = 40/3
        return padding
    }
}

extension CatalogViewController: GameItemCellDelegate {
    func clickToAddFavoriteGame(gameId: Int) {
        if let game = findGameBy(id: gameId) {
            repository?.addFavoriteGame(game, completion: handleGetMoreTopGames)
        }
    }
    
    func clickToRemoveFavoriteGame(gameId: Int) {
        if let game = findGameBy(id: gameId) {
            repository?.removeFavoriteGame(game, completion: handleGetMoreTopGames)
        }
    }
}
