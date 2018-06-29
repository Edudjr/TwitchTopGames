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
    var twitchAPI: TwitchAPIProtocol?
    var gamesModel: GamesModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        setupModel()
        setupCollectionViewCellSize()
        fetchNextTopGames()
    }
    
    private func setupModel(){
        gamesModel = GamesModel()
        gamesModel?.data = [GameModel]()
    }
    
    private func setupCollectionViewCellSize(){
        let padding: CGFloat = 20.0
        let width = view.frame.width / 2 - padding
        let height = width * 1.2
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func fetchNextTopGames(_ nextFor: String? = nil) {
        twitchAPI?.getTopGames(nextFor, completion: { (success, games) in
            if success {
                //Only append if cursor is different (response is not the same)
                if self.gamesModel?.paginationCursor == games?.paginationCursor {
                    return
                }
                
                if let data = games?.data {
                    self.gamesModel?.data? += data
                    self.gamesModel?.paginationCursor = games?.paginationCursor
                    self.collectionView.reloadData()
                }
            }
            
        })
    }
}


extension CatalogViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameItemCollectionViewCellIdentifier", for: indexPath) as? GameItemCollectionViewCell {
            if let game = gamesModel?.data?[indexPath.row] {
                cell.titleLabel.text = game.name
                if let art = game.boxArtUrl {
                    let url = art
                        .replacingOccurrences(of: "{width}", with: "400")
                        .replacingOccurrences(of: "{height}", with: "500")
                    cell.gameImage.kf.setImage(with: URL(string: url), placeholder: #imageLiteral(resourceName: "placeholder"))
                }
                
            }

            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = gamesModel?.data?.count else { return 0 }
        return count
    }
    
    //Infinite scroll
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = gamesModel?.data?.count else { return }
        if indexPath.row == count - 1 {
            fetchNextTopGames(gamesModel?.paginationCursor)
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
