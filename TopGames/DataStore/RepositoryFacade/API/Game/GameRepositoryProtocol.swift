//
//  GameRepositoryProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

typealias CompletionWithRepositoryGame = (Bool, RepositoryGameModel?)->Void

protocol GameRepositoryProtocol {
    func getGameBy(id: String, completion: @escaping CompletionWithRepositoryGame)
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame)
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame)
}
