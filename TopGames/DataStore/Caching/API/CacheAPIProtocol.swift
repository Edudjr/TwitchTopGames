//
//  CacheAPIProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 30/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

typealias CompletionWithGameModelCaches = (Bool, [GameModelCache]?)->Void

protocol CacheAPIProtocol {
    func getAllFavoriteGames(completion: @escaping CompletionWithGameModelCaches)
    func addFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches)
    func removeFavoriteGame(_ game: GameModelCache, completion: @escaping CompletionWithGameModelCaches)
}
