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
    //MARK: IBOutlets
    @IBOutlet weak var rockCircleImageView: UIImageView!
    @IBOutlet weak var paperCircleImageView: UIImageView!
    @IBOutlet weak var scissorsCircleImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startRoundButton: UIButton!
    
    //MARK: Other Properties
    var deviceConnection: DeviceConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection?.methodDelegate = self
        scissorsCircleImageView.isHidden = true
        paperCircleImageView.isHidden = true
        rockCircleImageView.isHidden = true
        self.modalPresentationStyle = .currentContext
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       startRoundButton.isHidden = false
    }

    @IBAction func startRoundButtonTapped(_ sender: Any) {
        startRoundButton.isHidden = true
        rockCircleImageView.isHidden = false
        paperCircleImageView.isHidden = false
        scissorsCircleImageView.isHidden = false
        configureTimer()
        addGestureRecognizers()
    }
    
    
    //MARK: Private Methods
    @objc private func rockMethodWasSelected() {
        print("rockMethodSent")
        playerMethod = PlayerMethod.rock
        updateImageViews(method: .rock)
    }
    @objc private func paperMethodWasSelected() {
        print("paperMethodSent")
        playerMethod = PlayerMethod.paper
        updateImageViews(method: .paper)
    }
    @objc private func scissorsMethodWasSelected() {
        print("scissorsMethodSent")
        playerMethod = PlayerMethod.scissors
        updateImageViews(method: .scissors)
    }
    @objc private func updateTimeLabel() {
        remainingTime -= 1
        if remainingTime < 4 && remainingTime > 1 {
            timeLabel.textColor = .red
            timeLabel.animateText()
        }
        if remainingTime <= 2 {
            deviceConnection?.send(method: playerMethod!)
        }
        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil
            performSegue(withIdentifier: "GameResultsSegue", sender: self)
        }
        timeLabel.text = "\(remainingTime)"
    }
    
    private func configureTimer() {
        timeLabel.text = "10"
        remainingTime = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GamePlayViewController.updateTimeLabel), userInfo: nil, repeats: true)
    }
    private func addGestureRecognizers() {
        rockCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rockMethodWasSelected)))
        paperCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(paperMethodWasSelected)))
        scissorsCircleImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scissorsMethodWasSelected)))
    }
    private func updateImageViews(method: PlayerMethod) {
        switch method {
        case .rock:
            if rockCircleImageView.image != UIImage(named:"circle") {
            rockCircleImageView.image = UIImage(named: "circle")
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
            if paperCircleImageView.image != UIImage(named:"circle") {
            paperCircleImageView.image = UIImage(named: "circle")
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
            if scissorsCircleImageView.image != UIImage(named:"circle") {
            scissorsCircleImageView.image = UIImage(named: "circle")
            }
        }
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

extension GamePlayViewController: DeviceMethodDelegate {
    func methodSelected(manager: DeviceConnection, method: PlayerMethod) {
        opponentMethod = method
        print(method.rawValue)
    }

}
