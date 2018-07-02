//
//  TwitchAPI.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation

class TwitchAPI: NetworkAPIProtocol {
    let baseURL = "https://api.twitch.tv"
    let headers = ["Client-ID": "xzqsdxt247xi72kder6l57r0aksbsh"]
    let provider: RequestProtocol?
    
    enum Endpoint: String {
        case topGames = "/helix/games/top"
    }
    
    public init(provider: RequestProtocol) {
        self.provider = provider
    }
    
    func getTopGames(_ fetchNextFromCursor: String?, completion: @escaping CompletionWithGames) {
        let url = baseURL + Endpoint.topGames.rawValue
        let params = ["after": fetchNextFromCursor ?? ""]
        provider?.request(url: url,
                          method: .get,
                          params: params,
                          headers: headers,
                          completion: { (response) in
                            
                            switch response.result {
                            case .success:
                                let code = response.response?.statusCode
                                if code != 200 && code != 201 {
                                    completion(false, nil)
                                    return
                                }
                                if let json = response.result.value as? [String: Any] {
                                    let games = NetworkGamesModel(object: json)
                                    completion(true, games)
                                } else {
                                    completion(false, nil)
                                }
                            case .failure:
                                completion(false, nil)
                            }
        })
    }
}
