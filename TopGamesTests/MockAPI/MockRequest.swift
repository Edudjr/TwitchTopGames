//
//  MockRequest.swift
//  TopGamesTests
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import Foundation
import Alamofire
@testable import TopGames


class MockRequest: RequestProtocol {
    enum ResponseType {
        case success, empty, failure
    }
    let responseType: ResponseType?
    
    public init(responseType: ResponseType) {
        self.responseType = responseType
    }
    
    func request(url: String, method: HTTPMethod, params: [String : Any]?, headers: HTTPHeaders?, completion: @escaping (DataResponse<Any>) -> Void) {
        
        //Get curresponding json 'base' filename for url
        var filename = getFilenameFor(url)!
        var response: DataResponse<Any>
        
        //Then append
        switch responseType! {
        case .success:
            filename.append("Success")
            response = getResponse(fileName: filename, url: "https://www.twitch.com", statusCode: 200)!
        case .failure:
            filename.append("Failure")
            response = getResponse(fileName: filename, url: "https://www.twitch.com", statusCode: 401)!
        case .empty:
            filename.append("Empty")
            response = getResponse(fileName: filename, url: "https://www.twitch.com", statusCode: 200)!
        }
        
        completion(response)
    }
    
    //Get corresponding json 'base' filename for url
    private func getFilenameFor(_ url: String) -> String? {
        guard let path = URL(string: url)?.path else { return nil }
        if path == "/helix/games/top" {
            return "TopGamesResponse"
        }
        return nil
    }
    
    //Create a response just like Alamofire responseJSON
    private func getResponse(fileName: String, url: String, statusCode: Int) -> DataResponse<Any>?  {
        let resp = HTTPURLResponse(url: URL(string: url)!, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        let json = getJsonFile(fileName) ?? ""
        let result = Result<Any>.success(json)
        let data = Data()
        let response = DataResponse<Any>(request: nil, response: resp, data: data, result: result)
        return response
    }
    
    //Get a file given a name
    private func getJsonFile(_ name: String) -> Any? {
        let bundle = Bundle(for: MockRequest.self)
        if let url = bundle.url(forResource: name, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                return json
            } catch {
                return nil
            }
        }
        return nil
    }
}

