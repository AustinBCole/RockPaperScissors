//
//  GamePlayViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {
    
    //MARK: Private Properties
    private var playerMethod: PlayerMethod?
    private var opponentMethod: PlayerMethod?
    private var timer: Timer?
    private var remainingTime = 0
    private var isFirstRound = true
    private let textLayer = CATextLayer()
    
    //MARK: IBOutlets
    @IBOutlet weak var rockCircleImageView: UIImageView!
    @IBOutlet weak var paperCircleImageView: UIImageView!
    @IBOutlet weak var scissorsCircleImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startRoundButton: UIButton!
    @IBOutlet weak var connectionLabel: UILabel!
    
    //MARK: Other Properties
    var deviceConnection: DeviceConnection?
    var loadingView: IndeterminateLoadingView?
    var isSubviewOfSuperview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection?.methodDelegate = self
        deviceConnection?.deviceDelegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        deviceConnection?.isReadyDelegate = self
        startRoundButton.isHidden = false
        configureImageViews()
        
        timeLabel.isHidden = true
        
        textLayer.isHidden = true
        
        
        paperCircleImageView.isUserInteractionEnabled = true
        paperCircleImageView.alpha = 1.0
        
        
        rockCircleImageView.isUserInteractionEnabled = true
        rockCircleImageView.alpha = 1.0
        
        
        scissorsCircleImageView.isUserInteractionEnabled = true
        scissorsCircleImageView.alpha = 1.0
        
        if (NewGameController.shared.isFirstRound && !NewGameController.shared.isSinglePlayer) || (!NewGameController.shared.isHost && !NewGameController.shared.isSinglePlayer) {
        startRoundButton.isUserInteractionEnabled = false
        startRoundButton.alpha = 0.5
        }
        if NewGameController.shared.isSinglePlayer {
            connectionLabel.isHidden = true
        }
    }
    
    
    @IBAction func startRoundButtonTapped(_ sender: Any) {
        deviceConnection?.send(isReady: true)
        startRound()
        deviceConnection?.stopAdvertising()
        NewGameController.shared.isFirstRound = false
    }
    
    //MARK: Private Methods
    @objc private func rockMethodWasSelected() {
        playerMethod = PlayerMethod.rock
        updateImageViews(method: .rock)
    }
    @objc private func paperMethodWasSelected() {
        playerMethod = PlayerMethod.paper
        updateImageViews(method: .paper)
    }
    @objc private func scissorsMethodWasSelected() {
        playerMethod = PlayerMethod.scissors
        updateImageViews(method: .scissors)
    }
    @objc private func updateTextLayer() {
        remainingTime -= 1
        if remainingTime >= 4 {
            deviceConnection?.send(method: playerMethod ?? PlayerMethod.paper)
        }
        if remainingTime < 4 && remainingTime >= 0 {
            textLayer.foregroundColor = UIColor.red.cgColor
            animateText(textLayer: textLayer)
            
            paperCircleImageView.isUserInteractionEnabled = false
            paperCircleImageView.alpha = 0.5
            rockCircleImageView.isUserInteractionEnabled = false
            rockCircleImageView.alpha = 0.5
            scissorsCircleImageView.isUserInteractionEnabled = false
            scissorsCircleImageView.alpha = 0.5
        }
        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil
            performSegue(withIdentifier: "GameResultsSegue", sender: self)
        }
        animateText(textLayer: textLayer)
        textLayer.string = "\(remainingTime)"
    }
    
    private func configureTimer() {
        textLayer.string = "10"
        textLayer.isHidden = false
        remainingTime = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GamePlayViewController.updateTextLayer), userInfo: nil, repeats: true)
    }
    private func addGestureRecognizers() {
        rockCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rockMethodWasSelected)))
        paperCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(paperMethodWasSelected)))
        scissorsCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scissorsMethodWasSelected)))
    }
    private func configureImageViews() {
        scissorsCircleImageView.isHidden = true
        scissorsCircleImageView.image = UIImage(named: "scissors")
        
        paperCircleImageView.isHidden = true
        paperCircleImageView.image = UIImage(named: "paper")
        
        rockCircleImageView.isHidden = true
        rockCircleImageView.image = UIImage(named: "rock")
    }
    private func updateImageViews(method: PlayerMethod) {
        switch method {
        case .rock:
            if rockCircleImageView.image != UIImage(named:"circle_fixed") {
                rockCircleImageView.image = UIImage(named: "circle_fixed")
            }
            if paperCircleImageView.image != UIImage(named:"paper") {
                paperCircleImageView.image = UIImage(named: "paper")
            }
            if scissorsCircleImageView.image != UIImage(named:"scissors") {
                scissorsCircleImageView.image = UIImage(named: "scissors")
            }
        case .paper:
            if rockCircleImageView.image != UIImage(named:"rock") {
                rockCircleImageView.image = UIImage(named: "rock")
            }
            if paperCircleImageView.image != UIImage(named:"circle_fixed") {
                paperCircleImageView.image = UIImage(named: "circle_fixed")
            }
            if scissorsCircleImageView.image != UIImage(named:"scissors") {
                scissorsCircleImageView.image = UIImage(named: "scissors")
            }
        case .scissors:
            if rockCircleImageView.image != UIImage(named:"rock") {
                rockCircleImageView.image = UIImage(named: "rock")
            }
            if paperCircleImageView.image != UIImage(named:"paper") {
                paperCircleImageView.image = UIImage(named: "paper")
            }
            if scissorsCircleImageView.image != UIImage(named:"circle_fixed") {
                scissorsCircleImageView.image = UIImage(named: "circle_fixed")
            }
        }
    }
    private func startRound() {
        startRoundButton.isHidden = true
        rockCircleImageView.isHidden = false
        paperCircleImageView.isHidden = false
        scissorsCircleImageView.isHidden = false
        configureTextLayer(textLayer: textLayer)
        configureTimer()
        addGestureRecognizers()
    }
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameResultsSegue" {
            guard let destinationVC = segue.destination as? GameResultsViewController else { return }
            
            destinationVC.playerMethod = self.playerMethod
            destinationVC.opponentMethod = self.opponentMethod
            destinationVC.deviceConnection = deviceConnection
        }
    }
}
extension GamePlayViewController: DeviceConnectionDelegate {
    func connectedDevicesChanged(manager: DeviceConnection, connectedDevices: [String]) {
        if connectedDevices.count == 0 {
            //If there is only one player left in the session, that player becomes the host.
            NewGameController.shared.isHost = true
            self.deviceConnection?.startAdvertising()
            OperationQueue.main.addOperation {
                self.connectionLabel.text = "Connections:"
                self.startRoundButton.isUserInteractionEnabled = false
                self.startRoundButton.alpha = 0.5
            }
        } else {
            OperationQueue.main.addOperation {
                self.deviceConnection?.stopAdvertising()
                self.connectionLabel.text = "Connections: \(connectedDevices)"
                if NewGameController.shared.isHost {
                    self.startRoundButton.isUserInteractionEnabled = true
                    self.startRoundButton.alpha = 1.0
                }
            }
        }
    }
}
extension GamePlayViewController: DeviceMethodDelegate {
    func methodSelected(manager: DeviceConnection, method: PlayerMethod) {
        opponentMethod = method
    }
}
extension GamePlayViewController: DeviceIsReadyDelegate {
    func opponentIsReady(manager: DeviceConnection, isReady: Bool) {
        OperationQueue.main.addOperation {
            self.startRound()
        }
    }
}
