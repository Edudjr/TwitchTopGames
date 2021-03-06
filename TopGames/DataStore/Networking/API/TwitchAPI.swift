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
        case games = "/helix/games"
        case topGames = "/helix/games/top"
        case streams = "/helix/streams"
    }
    
    public init(provider: RequestProtocol) {
        self.provider = provider
    }
    
    func getGameBy(id: String, completion: @escaping CompletionWithGame) {
        let url = baseURL + Endpoint.topGames.rawValue
        let params = ["id": id]
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
                                    if let game = games.data?.first {
                                        completion(true, game)
                                        return
                                    }
                                    completion(false, nil)
                                } else {
                                    completion(false, nil)
                                }
                            case .failure:
                                completion(false, nil)
                            }
        })
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
    
    func getGameStreams(first: Int, gameId: String, completion: @escaping CompletionWithStreams) {
        let first = String(describing: first)
        let url = baseURL + Endpoint.streams.rawValue
        let params = ["first": first, "gameId": gameId]
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
                                    let games = NetworkStreamsModel(object: json)
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
