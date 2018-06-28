//
//  TopGamesTests.swift
//  TopGamesTests
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import XCTest
import Swinject
import SwinjectStoryboard

@testable import TopGames

class TwitchAPITests: XCTestCase {
    var api: TwitchAPIProtocol?
    var emptyApi: TwitchAPIProtocol?
    var failureApi: TwitchAPIProtocol?
    
    override func setUp() {
        super.setUp()
        
        //Container with successful responses from Mock
        let container = Container()
        container.register(RequestProtocol.self) { _ in MockRequest(responseType: .success) }
        container.register(TwitchAPIProtocol.self) { r in
            TwitchAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        
        //Container injecting empty responses from Mock
        let containerEmpty = Container()
        containerEmpty.register(RequestProtocol.self) { _ in MockRequest(responseType: .empty) }
        containerEmpty.register(TwitchAPIProtocol.self) { r in
            TwitchAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        
        //Container injecting empty responses from Mock
        let containerFailure = Container()
        containerFailure.register(RequestProtocol.self) { _ in MockRequest(responseType: .failure) }
        containerFailure.register(TwitchAPIProtocol.self) { r in
            TwitchAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        
        api = container.resolve(TwitchAPIProtocol.self)
        emptyApi = containerEmpty.resolve(TwitchAPIProtocol.self)
        failureApi = containerFailure.resolve(TwitchAPIProtocol.self)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetTopGamesSuccess() {
        api?.getTopGames(nil, completion: { (success, games) in
            XCTAssertTrue(success)
            XCTAssertEqual(games?.data?.count, 20)
        })
    }
    
    func testGetTopGamesEmpty() {
        emptyApi?.getTopGames(nil, completion: { (success, games) in
            XCTAssertTrue(success)
            XCTAssertEqual(games?.data?.count, 0)
        })
    }
    
    func testGetTopGamesFailure() {
        failureApi?.getTopGames(nil, completion: { (success, games) in
            XCTAssertFalse(success)
            XCTAssertNil(games)
        })
    }
}
