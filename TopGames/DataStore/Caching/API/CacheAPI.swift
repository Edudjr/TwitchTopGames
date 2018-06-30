//
//  TwitchAPICache.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import RealmSwift

class cacheAPI: CacheAPIProtocol {
    let realm = try! Realm()
    
    func getAllFavoriteGames(completion: @escaping CompletionWithGameModelCaches) {
        let gamesCache = realm.objects(GameModelCache.self)
        var gamesCacheList = [GameModelCache]()
        for game in gamesCache {
            gamesCacheList.append(game)
        }
        completion(true, gamesCacheList)
    }
    
    func addFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches) {
        try! realm.write {
            realm.add(game)
        }
    }
    
    func removeFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches) {
        try! realm.write {
            realm.delete(game)
        }
    }
}
