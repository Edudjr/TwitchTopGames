//
//  CacheAPIProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 30/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

typealias CompletionWithGameModelCaches = (Bool, [GameModelCache]?)->Void
typealias CompletionWithGameModelCache = (Bool, GameModelCache?)->Void

protocol CacheAPIProtocol {
//    var shared: CacheAPIProtocol? { get set }
    func getAllFavoriteGames(completion: @escaping CompletionWithGameModelCaches)
    func getFavoriteGame(id: String, completion: @escaping CompletionWithGameModelCache)
    func addFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches)
    func removeFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches)
}
