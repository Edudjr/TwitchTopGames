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
        defaultContainer.register(NetworkAPIProtocol.self) { r in
            TwitchAPI(provider: r.resolve(RequestProtocol.self)!)
        }
        defaultContainer.register(CacheAPIProtocol.self) { r in
            CacheAPI()
        }
        defaultContainer.register(RepositoryProtocol.self) { r in
            CatalogRepositoryAPI(
                networkAPI: r.resolve(NetworkAPIProtocol.self)!,
                cacheAPI: r.resolve(CacheAPIProtocol.self)!
            )
        }
        defaultContainer.storyboardInitCompleted(CatalogViewController.self) { r, c in
            c.repository = r.resolve(RepositoryProtocol.self)
        }
    }
}
