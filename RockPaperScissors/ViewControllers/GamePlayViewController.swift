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
    
    //MARK: Other Properties
    var deviceConnection: DeviceConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection?.methodDelegate = self
        rockCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.rockMethodWasSelected)))
        paperCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.paperMethodWasSelected)))
        scissorsCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.scissorsMethodWasSelected)))
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
       timeLabel.text = "10"
        remainingTime = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GamePlayViewController.updateTimeLabel), userInfo: nil, repeats: true)
    }

    //MARK: Private Methods
    @objc private func rockMethodWasSelected() {
        deviceConnection?.send(method: .rock)
    }
    @objc private func paperMethodWasSelected() {
        deviceConnection?.send(method: .paper)

    }
    @objc private func scissorsMethodWasSelected() {
        deviceConnection?.send(method: .scissors)
    }
    @objc private func updateTimeLabel() {
        remainingTime -= 1
        if remainingTime < 4 {
            timeLabel.textColor = .red
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
    }

}
