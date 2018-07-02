//
//  TwitchAPICache.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import RealmSwift

class CacheAPI: CacheAPIProtocol {
    let realm = try! Realm()
    
    func getAllFavoriteGames(completion: @escaping CompletionWithGameModelCaches) {
        let gamesCache = realm.objects(GameModelCache.self)
        var gamesCacheList = [GameModelCache]()
        for game in gamesCache {
            gamesCacheList.append(game)
        }
        completion(true, gamesCacheList)
    }
    
    func getFavoriteGame(id: String, completion: @escaping CompletionWithGameModelCache) {
        if let game = realm.objects(GameModelCache.self).filter("id == '\(id)'").first {
            completion(true, game)
        } else {
            completion(false, nil)
        }
    }
    
    func addFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches) {
        try! realm.write {
            realm.add(game)
        }
        getAllFavoriteGames(completion: completion)
    }
    
    func removeFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches) {
        try! realm.write {
            realm.delete(game)
        }
        getAllFavoriteGames(completion: completion)
    }
}
