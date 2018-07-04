//
//  GameRepositoryProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

typealias CompletionWithRepositoryGame = (Bool, RepositoryGameModel?)->Void
typealias CompletionWithInt = (Bool, Int?)->Void

protocol GameRepositoryProtocol {
    func getGameViewsBy(id: String, completion: @escaping CompletionWithInt)
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame)
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGame)
}
