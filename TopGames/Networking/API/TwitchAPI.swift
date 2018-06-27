//
//  TwitchAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class TwitchAPI: TwitchAPIProtocol {
    let baseURL = "https://api.twitch.tv"
    let headers = ["Client-ID": "xzqsdxt247xi72kder6l57r0aksbsh"]
    let provider: RequestProtocol?
    
    enum Endpoint: String {
        case topGames = "/helix/games/top"
    }
    
    public init(provider: RequestProtocol) {
        self.provider = provider
    }
    
    func getTopGames(page: Int, completion: @escaping CompletionWithAny) {
        let url = baseURL + Endpoint.topGames.rawValue
        provider?.request(url: url,
                          method: .get,
                          params: nil,
                          headers: headers,
                          completion: { (data) in
            completion(data)
        })
    }
}
