//
//  GamePlayViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    private var opponentMethod: PlayerMethod?
    
    var deviceConnection: DeviceConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection?.methodDelegate = self
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

}

extension GamePlayViewController: DeviceMethodDelegate {
    func methodSelected(method: PlayerMethod) {
        opponentMethod = method
    }

}
