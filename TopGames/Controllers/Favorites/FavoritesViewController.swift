//
//  FavoritesViewController.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 29/06/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CatalogViewController {
            //Overriding default Injection done by SwinjectStoryboard
            destination.repository = FavoritesRepositoryAPI(cacheAPI: CacheAPI())
            destination.screenTitle = "Favoritos"
        }
    }
}
