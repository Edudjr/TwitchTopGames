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
    private var shouldFetch = true
    private var lastFetchedCount = 0
    
    var screenTitle = ""
    var repository: CatalogRepositoryProtocol?
    var currentGames: [RepositoryGameModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.isHidden = true
        setupCollectionViewCellSize()
        repository?.getMoreTopGames(completion: handleGetMoreTopGames)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = screenTitle
        repository?.getCurrentGames(completion: { (success, games) in
            if success {
                self.currentGames = games!
                self.lastFetchedCount = games!.count
            }
        })
    }
    
    private func setupCollectionViewCellSize(){
        let padding: CGFloat = 20.0
        let width = view.frame.width / 2 - padding
        let height = width * 1.2
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func findGameIndexBy(id: Int) -> Int? {
        let index = currentGames?.index(where: { (repoGame) -> Bool in
            repoGame.id! == id
        })
        return index
    }
    
    private func handleGetMoreTopGames(success: Bool, games: [RepositoryGameModel]?) {
        //Don't reload if fetched games are the same as the current ones
        if success, let games = games, games.count != lastFetchedCount {
            self.currentGames = games
            self.lastFetchedCount = games.count
        }
        //TODO: Alert for failure
    }
    
    // Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameDetailsViewController, let game = sender as? RepositoryGameModel {
            destination.gameId = String(describing: game.id!)
            destination.gameTitle = game.name
            destination.gameThumbnail = game.thumbnail
            destination.isFavorite = game.isFavorite
        }
    }
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCollectionViewCellIdentifier", for: indexPath) as? GameItemCollectionViewCell {
            if let game = currentGames?[indexPath.row] {
                cell.delegate = self
                cell.id = game.id
                cell.titleLabel.text = game.name
                cell.gameImage.kf.setImage(with: URL(string: game.thumbnail ?? ""), placeholder: #imageLiteral(resourceName: "placeholder"))
                cell.favoriteButton.isSelected = game.isFavorite ?? false
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let game = currentGames?[indexPath.row] {
            performSegue(withIdentifier: "DetailsSegue", sender: game)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = currentGames?.count {
            if count == 0 {
                containerView.isHidden = false
                collectionView.isHidden = true
            } else {
                containerView.isHidden = true
                collectionView.isHidden = false
            }
            return count
        }
        return 0
    }
    
    //Infinite scroll
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = currentGames?.count ?? 0
        let row = indexPath.row

        if row > count - 2 {
            if shouldFetch {
                repository?.getMoreTopGames(completion: handleGetMoreTopGames)
                shouldFetch = false
            }
        } else {
            shouldFetch = true
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
        if let index = findGameIndexBy(id: gameId), let game = currentGames?[index] {
            repository?.addFavoriteGame(game, completion: { (success, games) in
                //Only set model if successful
                if success {
                    self.currentGames![index].isFavorite = true
                }
                self.handleGetMoreTopGames(success: success, games: games)
            })
        }
    }
    
    func clickToRemoveFavoriteGame(gameId: Int) {
        if let index = findGameIndexBy(id: gameId), let game = currentGames?[index] {
            currentGames![index].isFavorite = false
            repository?.removeFavoriteGame(game, completion: { (success, games) in
                //Only set model if successful
                if success {
                    self.currentGames![index].isFavorite = false
                }
                self.handleGetMoreTopGames(success: success, games: games)
            })
        }
    }
}
