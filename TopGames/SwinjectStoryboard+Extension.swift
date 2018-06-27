//
//  SwinjectStoryboard+Extension.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 27/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//
import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer.register(RequestProtocol.self) { _ in AlamofireRequest() }
        defaultContainer.register(TwitchAPIProtocol.self) { r in
            TwitchAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        defaultContainer.storyboardInitCompleted(ViewController.self) { r, c in
            c.twitchAPI = r.resolve(TwitchAPIProtocol.self)
        }
    }
}
