//
//  RepositoryProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 30/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
typealias CompletionWithRepositoryGames = (Bool, [RepositoryGameModel]?)->Void

protocol RepositoryProtocol {
    func getMoreTopGames(completion: @escaping CompletionWithRepositoryGames)
    func addFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames)
    func removeFavoriteGame(_ game: RepositoryGameModel, completion: @escaping CompletionWithRepositoryGames)
}
