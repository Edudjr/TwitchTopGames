//
//  NetworkStreamsModel.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 03/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Marshal

struct NetworkStreamsModel: Unmarshaling{
    var data: [NetworkStreamModel]?
    var paginationCursor: String?
}

extension NetworkStreamsModel{
    init(object: MarshaledObject){
        data = try? object.value(for: "data")
        paginationCursor = try? object.value(for: "pagination.cursor")
    }
}
