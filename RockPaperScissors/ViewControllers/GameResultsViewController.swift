//
//  GameResultsViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GameResultsViewController: UIViewController {
    //MARK: Private Properties
    private var winningMethod: PlayerMethod?
    private var losingMethod: PlayerMethod?
    private var gameResults: (winningMethod: PlayerMethod, losingMethod: PlayerMethod)?
    
    //MARK: Other Properties
    var playerMethod: PlayerMethod?
    var opponentMethod: PlayerMethod?
    var deviceConnection: DeviceConnection?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameResults = MechanicsController.resolveGame(playerMethod: playerMethod!, opponentMethod: opponentMethod!)
        
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
