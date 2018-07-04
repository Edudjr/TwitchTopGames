//
//  GameModelCache.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import RealmSwift

class GameModelCache: Object {
    @objc dynamic var id: String? = nil
    @objc dynamic var name: String? = ""
    @objc dynamic var thumbnail: String? = ""
}
