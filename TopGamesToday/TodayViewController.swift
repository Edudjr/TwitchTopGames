//
//  TodayViewController.swift
//  TopGamesToday
//
//  Created by Eduardo Domene Junior on 04/07/18.
//  Copyright © 2018 Eduardo Domene Junior. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    var network = TwitchAPI(provider: AlamofireRequest())
    var currentGames = [String]()
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        tableview.delegate = self
        tableview.dataSource = self
        extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        network.getTopGames(nil) { (success, gamesModel) in
            if success, let games = gamesModel?.data {
                for (index, game) in games.enumerated() {
                    self.currentGames.append("#\(index+1) - \(game.name!)")
                    if index == 2 {
                        self.tableview.reloadData()
                        break
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .expanded {
            preferredContentSize = CGSize(width: 0, height: 180)
        } else {
            preferredContentSize = maxSize
        }
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGames.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "topgames://")!
        self.extensionContext?.open(url, completionHandler: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCell", for: indexPath) as? TodayTableViewCell {
            let game = currentGames[indexPath.row]
            cell.gameTitle.text = game
            return cell
            
        }
        return UITableViewCell()
    }
}
