//
//  GamesModel.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct NetworkGamesModel: Unmarshaling{
    var data: [NetworkGameModel]?
    var paginationCursor: String?
}

extension NetworkGamesModel{
    init(object: MarshaledObject){
        data = try? object.value(for: "data")
        paginationCursor = try? object.value(for: "pagination.cursor")
    }
}
