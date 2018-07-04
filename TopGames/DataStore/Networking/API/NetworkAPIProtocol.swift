//
//  TwitchAPIProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
typealias CompletionWithGames = (Bool, NetworkGamesModel?)->Void

protocol NetworkAPIProtocol {
    func getTopGames(_ fetchNextFromCursor: String?, completion: @escaping CompletionWithGames)
}
