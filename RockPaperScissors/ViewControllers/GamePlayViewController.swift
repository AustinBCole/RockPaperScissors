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
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
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
    @objc private func rockMethodWasSelected() {
        print("rockMethodSent")
        deviceConnection?.send(method: .rock)
    }
    @objc private func paperMethodWasSelected() {
        print("paperMethodSent")
        deviceConnection?.send(method: .paper)

    }
    @objc private func scissorsMethodWasSelected() {
        print("scissorsMethodSent")
        deviceConnection?.send(method: .scissors)
    }
    @objc private func updateTimeLabel() {
        remainingTime -= 1
        if remainingTime < 4 && remainingTime > 1 {
            timeLabel.textColor = .red
            timeLabel.animateText()
        }
        if remainingTime <= 0 {
            timer?.invalidate()
            timer = nil
        }
        timeLabel.text = "\(remainingTime)"
    }
}

extension GamePlayViewController: DeviceMethodDelegate {
    func methodSelected(method: PlayerMethod) {
        opponentMethod = method
        print(method.rawValue)
    }

}
