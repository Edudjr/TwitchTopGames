//
//  RequestProtocol.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
import Foundation
import Alamofire

protocol RequestProtocol {
    func request(url: String,
                 method: HTTPMethod,
                 params: [String: Any]?,
                 headers: HTTPHeaders?,
                 completion: @escaping(Any) -> Void)
}
