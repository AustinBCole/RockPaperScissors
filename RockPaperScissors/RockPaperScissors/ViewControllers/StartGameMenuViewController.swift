//
//  StartGameMenuViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class StartGameMenuViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var joinGameButton: UIButton!
    
    //MARK: Private Properties
    private let deviceConnection = DeviceConnection()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection.deviceDelegate = self
        presentInstructionsAlert()
    }
    override func viewWillAppear(_ animated: Bool) {
        deviceConnection.stopAdvertising()
    }
    
    
    @IBAction func helpButtonTapped(_ sender: Any) {
        presentInstructionsAlert()
    }
    @IBAction func hostGameButton(_ sender: Any) {
        deviceConnection.startAdvertising()
        deviceConnection.stopBrowsing()
    }
    @IBAction func joinGameButton(_ sender: Any) {
        deviceConnection.startBrowsing()
        joinGameButton.setTitle("Connecting...", for: .normal)
    }
    @IBAction func singlePlayerButton(_ sender: Any) {
        NewGameController.shared.isSinglePlayer = true
        NewGameController.shared.isHost = true
        deviceConnection.stopBrowsing()
    }
    
    private func presentInstructionsAlert() {
        let instructionsAlert = UIAlertController(title: "Welcome!", message: "To start a game, please tap the \"Host Game\" button. You will then be redirected to the gameplay view to await the connection of a nearby device. To join a game that has already been hosted by a nearby device, please tap the \"Join Game\" button. You will be redirected to the gameplay view where the host can start the round. If you would prefer to go it alone, tap the \"Single Player\" button. Enjoy!", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Got it!", style: .default, handler: nil)
        instructionsAlert.addAction(okayAction)
        self.present(instructionsAlert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! GamePlayViewController
        destinationVC.deviceConnection = self.deviceConnection
        if segue.identifier == "HostGameSegue" {
        NewGameController.shared.isHost = true
        }
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
