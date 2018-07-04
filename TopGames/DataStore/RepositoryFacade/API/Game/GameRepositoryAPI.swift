//
//  GameRepositoryAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class GameRepositoryAPI: GameRepositoryProtocol {
    var networkAPI: NetworkAPIProtocol?
    var cacheAPI: CacheAPIProtocol?
    
    public init(networkAPI: NetworkAPIProtocol, cacheAPI: CacheAPIProtocol) {
        self.networkAPI = networkAPI
        self.cacheAPI = cacheAPI
    }
    
    func getGameBy(id: String, completion: @escaping CompletionWithRepositoryGame) {
        networkAPI?.getGameStreams(first: 1, gameId: id, completion: { (success, streams) in
            if success {
                self.cacheAPI?.getFavoriteGame(id: id, completion: { (success, cachedGame) in
                    let stream = streams!.data!.first
                    let repoGame = RepositoryGameModel(id: Int(stream?.gameId ?? "0"),
                                                       name: nil,
                                                       thumbnail: stream?.thumbnail,
                                                       viewersCount: stream?.viewerCount,
                                                       isFavorite: success)
                    completion(true, repoGame)
                    return
                })
            }
            completion(false, nil)
        })
    }
    
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame) {
        guard let id = game.id else {
            completion(false, nil)
            return
        }
        let cachedGame = GameModelCache()
        cachedGame.id = "\(id)"
        cachedGame.name = game.name
        cachedGame.thumbnail = game.thumbnail
        
        cacheAPI?.addFavoriteGame(cachedGame, completion: { (success, gameCacheList) in
            if success {
                var clone = game
                clone.isFavorite = true
                completion(true, clone)
            } else {
                completion(false, nil)
            }
        })
    }
    
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame) {
        let gameId = String(describing: game.id ?? 0)
        cacheAPI?.getFavoriteGame(id: gameId, completion: { (success, favGame) in
            if success {
                self.cacheAPI?.removeFavoriteGame(favGame!, completion: { (success, cachedGames) in
                    if success {
                        var clone = game
                        clone.isFavorite = false
                        completion(true, clone)
                        return
                    }
                })
            }
        })
        completion(false, nil)
    }
}
