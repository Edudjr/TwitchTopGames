//
//  TopGamesViewController.swift
//  TopGames
//
//  Created by Eduardo Domene Junior on 04/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit

class TopGamesViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CatalogViewController {
            destination.screenTitle = "Top Games"
        }
    }
}
