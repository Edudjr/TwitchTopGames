//
//  AlamofireRequest.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequest: RequestProtocol {
    func request(url: String,
                 method: HTTPMethod,
                 params: [String : Any]?,
                 headers: HTTPHeaders?,
                 completion: @escaping (Any) -> Void) {
       
        Alamofire.request(url,
                          method: method,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers)
            .responseJSON { (data) in
                completion(data)
        }
    }
}
