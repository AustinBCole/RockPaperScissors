//
//  StartGameMenuViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class StartGameMenuViewController: UIViewController {
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var joinGameButton: UIButton!
    
    let deviceConnection = DeviceConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection.deviceDelegate = self
    }
    
    @IBAction func hostGameButton(_ sender: Any) {
        deviceConnection.startAdvertising()
    }
    @IBAction func joinGameButton(_ sender: Any) {
        deviceConnection.startBrowsing()
        joinGameButton.setTitle("Connecting...", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! GamePlayViewController
        destinationVC.deviceConnection = self.deviceConnection
    }
}



extension StartGameMenuViewController: DeviceConnectionDelegate {
    func connectedDevicesChanged(manager: DeviceConnection, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.performSegue(withIdentifier: "JoinGameSegue", sender: self)
        }
        deviceConnection.stopBrowsing()
    }
}
