//
//  TwitchAPICache.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class TwitchAPICache: TwitchAPIProtocol {
    func getTopGames(_ fetchNextFromCursor: String?, completion: @escaping CompletionWithGames) {
        var gamesModel = GamesModel()
        let game1 = GameModel(id: "460630",
                              name: "Tom Clancy's Rainbow Six: Siege",
                              boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/Tom%20Clancy%27s%20Rainbow%20Six:%20Siege-{width}x{height}.jpg")
        let game2 = GameModel(id: "497878",
                              name: "Fighting EX Layer",
                              boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/Fighting%20EX%20Layer-{width}x{height}.jpg")
        let game3 = GameModel(id: "458353",
                              name: "Darkest Dungeon",
                              boxArtUrl: "https://static-cdn.jtvnw.net/ttv-boxart/Darkest%20Dungeon-{width}x{height}.jpg")
        gamesModel.data = [game1, game2, game3]
        gamesModel.paginationCursor = "1"
        
        completion(true, gamesModel)
    }
}
