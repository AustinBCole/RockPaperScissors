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
    @IBOutlet weak var connectedDevicesLabel: UILabel!
    
    let deviceConnection = DeviceConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection.deviceDelegate = self
    }
    
    @IBAction func connectButton(_ sender: Any) {
        deviceConnection.startAdvertising()
        deviceConnection.startBrowsing()
        connectButton.setTitle("Connecting...", for: .normal)
    }
}

extension StartGameMenuViewController: DeviceConnectionDelegate {
    func connectedDevicesChanged(manager: DeviceConnection, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.newGameButton.isHidden = false
            self.connectButton.setTitle("Connected!", for: .normal)
            self.connectedDevicesLabel.text = "1"
        }
        deviceConnection.stopBrowsing()
        deviceConnection.stopAdvertising()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                guard let destinationVC = segue.destination as? GamePlayViewController else { return }
            
        destinationVC.deviceConnection = deviceConnection
        }
}
