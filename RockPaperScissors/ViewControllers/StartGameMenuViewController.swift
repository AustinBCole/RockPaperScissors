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
    @IBOutlet weak var connectButton: UIButton!
    
    let deviceConnection = DeviceConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection.deviceDelegate = self
    }
    
    @IBAction func connectButton(_ sender: Any) {
        deviceConnection.startBroadcasting()
        connectButton.setTitle("Connecting...", for: .normal)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? GamePlayViewController else { return }
        
        destinationVC.deviceConnection = self.deviceConnection
    }
}

extension StartGameMenuViewController: DeviceConnectionDelegate {
    
    func connectedDevicesChanged() {
        newGameButton.isHidden = false
        connectButton.setTitle("Connected!", for: .normal)
        deviceConnection.stopBroadcasting()
    }
    
    
}
