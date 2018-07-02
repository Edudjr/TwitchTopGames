//
//  RepositoryAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 30/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class CatalogRepositoryAPI: RepositoryProtocol {
    var networkAPI: NetworkAPIProtocol?
    var cacheAPI: CacheAPIProtocol?
    
    var currentGames = [RepositoryGameModel]()
    var cachedGames = [GameModelCache]()
    var currentCursor = ""
    
    public init(networkAPI: NetworkAPIProtocol, cacheAPI: CacheAPIProtocol) {
        self.networkAPI = networkAPI
        self.cacheAPI = cacheAPI
    }
    
    func getMoreTopGames(completion: @escaping CompletionWithRepositoryGames) {
        //let cursor = gamesModel?.paginationCursor
        networkAPI?.getTopGames(currentCursor, completion: { (success, networkGames) in
            if success {
                //Only append if cursor is different (response is not the same)
                if self.currentCursor == networkGames?.paginationCursor {
                    return
                }
                //Append to currentGames
                self.appendToCurrentGames(fromNetworkGames: networkGames!.data!)
                //Check if current games are saved on cache
                self.applyFavoriteGamesFromCache()
                //Set cursor
                self.currentCursor = networkGames!.paginationCursor!
                
                //Return currentGames
                completion(true, self.currentGames)
            } else {
                completion(false, nil)
            }
        })
    }
    
    func getCurrentGames(completion: @escaping CompletionWithRepositoryGames) {
        completion(true, currentGames)
    }
    
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames) {
        guard let id = game.id else {
            completion(false, nil)
            return
        }
        let cachedGame = GameModelCache()
        cachedGame.id = "\(id)"
        cachedGame.name = game.name
        cachedGame.thumbnail = game.thumbnail
        
        setFavoriteGame(game)
        
        cacheAPI?.addFavoriteGame(cachedGame, completion: { (success, gameCacheList) in
            if success {
                completion(true, self.currentGames)
            } else {
                completion(false, nil)
            }
        })
    }
    
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames) {
        //
    }
}

extension CatalogRepositoryAPI {
    private func setFavoriteGame(_ game: RepositoryGameModel) {
        guard let id = game.id,
            let index = currentGames.index(where: { (repoGame) -> Bool in
                repoGame.id == id
            })
            else { return }
        
        currentGames[index].isFavorite = true
    }
    
    private func applyFavoriteGamesFromCache() {
        for (index, game) in currentGames.enumerated() {
            let id = String(describing: game.id ?? 0)
            cacheAPI?.getFavoriteGame(id: id, completion: { (success, cachedGame) in
                if success {
                    self.currentGames[index].isFavorite = true
                }
            })
        }
    }
    
    private func appendToCurrentGames(fromNetworkGames games: [NetworkGameModel]) {
        for game in games {
            if let repoGame = createRepositoryGame(fromNetworkGame: game) {
                self.currentGames.append(repoGame)
            }
        }
    }
    
    private func createRepositoryGame(fromNetworkGame game: NetworkGameModel) -> RepositoryGameModel? {
        guard let id = game.id, let name = game.name, let url = game.boxArtUrl else { return nil }
        let thumb = url
            .replacingOccurrences(of: "{width}", with: "400")
            .replacingOccurrences(of: "{height}", with: "500")

        return RepositoryGameModel(id: Int(id), name: name, thumbnail: thumb, isFavorite: nil)
    }
}
