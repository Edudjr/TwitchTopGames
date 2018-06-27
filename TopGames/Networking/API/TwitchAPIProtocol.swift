//
//  TwitchAPIProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
typealias CompletionWithAny = (Any)->Void

protocol TwitchAPIProtocol {
    func getTopGames(page: Int, completion: @escaping CompletionWithAny)
}
