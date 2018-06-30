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
    var gamesModel: GamesModel?
    
    public init(networkAPI: NetworkAPIProtocol, cacheAPI: CacheAPIProtocol) {
        self.networkAPI = networkAPI
        self.cacheAPI = cacheAPI
        setupModel()
    }
    
    func getMoreTopGames(completion: @escaping CompletionWithRepositoryGames) {
        let cursor = gamesModel?.paginationCursor
        networkAPI?.getTopGames(cursor, completion: { (success, gamesModel) in
            if success {
                //Only append if cursor is different (response is not the same)
                if self.gamesModel?.paginationCursor == gamesModel?.paginationCursor {
                    return
                }
                self.updateGamesModelWith(gamesModel)
                
                //Convert to repo model and return games
                var repoGames = [RepositoryGameModel]()
                if let games = self.gamesModel?.data {
                    for game in games {
                        if let repoGame = self.getRepositoryGameModelFrom(game) {
                            repoGames.append(repoGame)
                        }
                    }
                    completion(true, repoGames)
                } else {
                    completion(false, nil)
                }
            }
        })
    }
    
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames) {
        guard let id = game.id else {
            completion(false, nil)
            return
        }
        let gameCache = GameModelCache()
        gameCache.id = "\(id)"
        gameCache.name = game.name
        gameCache.thumbnail = game.thumbnail
        
        var repoGameList = [RepositoryGameModel]()
        cacheAPI?.addFavoriteGame(gameCache, completion: { (success, gameCacheList) in
            if success, let list = gameCacheList {
                for game in list {
                    let repoGame = RepositoryGameModel(id: Int(id), name: game.name, thumbnail: game.thumbnail)
                    repoGameList.append(repoGame)
                }
                completion(true, repoGameList)
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
    private func setupModel(){
        gamesModel = GamesModel()
        gamesModel?.data = [GameModel]()
    }
    
    private func updateGamesModelWith(_ gamesModel: GamesModel?) {
        if let data = gamesModel?.data {
            self.gamesModel?.data?.append(contentsOf: data)
            self.gamesModel?.paginationCursor = gamesModel?.paginationCursor
        }
    }
    
    private func getRepositoryGameModelFrom(_ game: GameModel) -> RepositoryGameModel? {
        guard let id = game.id, let name = game.name, let url = game.boxArtUrl else { return nil }
        let thumb = url
            .replacingOccurrences(of: "{width}", with: "400")
            .replacingOccurrences(of: "{height}", with: "500")
        
        return RepositoryGameModel(id: Int(id), name: name, thumbnail: thumb)
    }
}
