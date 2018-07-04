//
//  FavoritesRepositoryAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 01/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

//
//  RepositoryAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 30/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class FavoritesRepositoryAPI: CatalogRepositoryProtocol {
    var cacheAPI: CacheAPIProtocol?
    var currentGames = [RepositoryGameModel]()
    
    public init(cacheAPI: CacheAPIProtocol) {
        self.cacheAPI = cacheAPI
    }
    
    func getMoreTopGames(completion: @escaping CompletionWithRepositoryGames) {
        cacheAPI?.getAllFavoriteGames(completion: { (success, cachedGames) in
            if success {
                //Convert to repo model and return games
                self.appendToCurrentGames(fromGameModelCache: cachedGames!)
                completion(true, self.currentGames)
            } else {
                completion(false, nil)
            }
        })
    }
    
    func getCurrentGames(completion: @escaping CompletionWithRepositoryGames) {
        getMoreTopGames(completion: completion)
    }
    
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames) {
      //
    }
    
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames) {
        //delete from currentGames
        let gameId = String(describing: game.id ?? 0)
        cacheAPI?.getFavoriteGame(id: gameId, completion: { (success, game) in
            if success {
                self.cacheAPI?.removeFavoriteGame(game!, completion: { (success, cachedGames) in
                    if success {
                        self.appendToCurrentGames(fromGameModelCache: cachedGames!)
                        completion(true, self.currentGames)
                        return
                    }
                })
            }
        })
        completion(false, nil)
    }
}

extension FavoritesRepositoryAPI {
    private func appendToCurrentGames(fromGameModelCache games: [GameModelCache]) {
        self.currentGames.removeAll()
        for game in games {
            if let repoGame = createRepositoryGameModel(fromGameModelCache: game) {
                self.currentGames.append(repoGame)
            }
        }
    }
    private func createRepositoryGameModel(fromGameModelCache game: GameModelCache) -> RepositoryGameModel? {
        guard let id = game.id, let name = game.name, let thumb = game.thumbnail else { return nil }
        let intId = Int(id)
        let game = RepositoryGameModel(id: intId, name: name, thumbnail: thumb, isFavorite: true)
        return game
    }
}
