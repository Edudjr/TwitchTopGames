//
//  TwitchAPIProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
typealias CompletionWithGames = (Bool, GamesModel?)->Void

protocol NetworkAPIProtocol {
    func getTopGames(_ fetchNextFromCursor: String?, completion: @escaping CompletionWithGames)
    func addFavoriteGame(_ game: GameModel, completion: @escaping CompletionWithGames)
    func removeFavoriteGame(_ game: GameModel, completion: @escaping CompletionWithGames)
}
