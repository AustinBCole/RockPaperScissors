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
    
    //MARK: IBOutlets
    @IBOutlet weak var rockCircleImageView: UIImageView!
    @IBOutlet weak var paperCircleImageView: UIImageView!
    @IBOutlet weak var scissorsCircleImageView: UIImageView!
    
    //MARK: Other Properties
    var deviceConnection: DeviceConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceConnection?.methodDelegate = self
        
        rockCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.rockMethodWasSelected)))
        paperCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.paperMethodWasSelected)))
        scissorsCircleImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(GamePlayViewController.scissorsMethodWasSelected)))
        
        
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
}

extension GamePlayViewController: DeviceMethodDelegate {
    func methodSelected(method: PlayerMethod) {
        opponentMethod = method
    }

}
