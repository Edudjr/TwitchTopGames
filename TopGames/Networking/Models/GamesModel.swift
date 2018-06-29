//
//  GamesModel.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct GamesModel: Unmarshaling{
    var data: [GameModel]?
    var paginationCursor: String?
}

extension GamesModel{
    init(object: MarshaledObject){
        data = try? object.value(for: "data")
        paginationCursor = try? object.value(for: "pagination.cursor")
    }
}
