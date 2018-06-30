//
//  GameModel.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
import Marshal

struct GameModel: Unmarshaling {
    var id: String?
    var name: String?
    var boxArtUrl: String?
}

extension GameModel{
    init(object: MarshaledObject){
        id = try? object.value(for: "id")
        name = try? object.value(for: "name")
        boxArtUrl = try? object.value(for: "box_art_url")
    }
}
