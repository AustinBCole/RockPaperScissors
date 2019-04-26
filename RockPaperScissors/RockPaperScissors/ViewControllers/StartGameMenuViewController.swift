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
        deviceConnection.startAdvertising()
        deviceConnection.startBrowsing()
        connectButton.setTitle("Connecting...", for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! GamePlayViewController
        destinationVC.deviceConnection = self.deviceConnection
    }
}



extension StartGameMenuViewController: DeviceConnectionDelegate {
    func connectedDevicesChanged(manager: DeviceConnection, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.newGameButton.isHidden = false
            self.connectButton.setTitle("Connected!", for: .normal)
        }
        deviceConnection.stopBrowsing()
        deviceConnection.stopAdvertising()
    }
}
extension StartGameMenuViewController: DeviceIsReadyDelegate {
    func opponentIsReady(manager: DeviceConnection, isReady: Bool) {
        if isReady == true {
            let destinationVC = GamePlayViewController()
            destinationVC.deviceConnection = self.deviceConnection
            present(destinationVC, animated: true, completion: nil)
        }
    }
}
