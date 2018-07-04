//
//  NetworkStreamModel.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct NetworkStreamModel: Unmarshaling {
    var id: String?
    var gameId: String?
    var viewerCount: Int?
    var thumbnail: String?
}

extension NetworkStreamModel{
    init(object: MarshaledObject){
        id = try? object.value(for: "id")
        gameId = try? object.value(for: "gameId")
        viewerCount = try? object.value(for: "viewer_count")
        thumbnail = try? object.value(for: "thumbnail_url")
    }
}
