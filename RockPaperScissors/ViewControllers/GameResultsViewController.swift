//
//  GameResultsViewController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit
import SpriteKit

class GameResultsViewController: UIViewController {
    //MARK: Private Properties
    private var gameResults: (winningMethod: PlayerMethod, losingMethod: PlayerMethod)?
    
    //MARK: Other Properties
    var playerMethod: PlayerMethod?
    var opponentMethod: PlayerMethod?
    var deviceConnection: DeviceConnection?
    
    //MARK: IBOutlets
    @IBOutlet weak var winningImageView: UIImageView!
    @IBOutlet weak var losingImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let gameResults = MechanicsController.resolveGame(playerMethod: playerMethod ?? PlayerMethod.rock, opponentMethod: opponentMethod ?? PlayerMethod.paper) else {return}
        winningImageView.image = UIImage(named: gameResults.winningMethod.rawValue)
        losingImageView.image = UIImage(named: gameResults.losingMethod.rawValue)
        print(winningImageView.constraints.map{$0.constant})
        entranceAnimation()
        
        
    }
    //MARK: Private Methods
    private func entranceAnimation() {
        let animationDuration = 3.0
        let position: CGFloat = 100.0
        let viewToAnimate = winningImageView
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                viewToAnimate?.frame.origin.x = (viewToAnimate?.frame.origin.x)! + position
            })
            UIView.addKeyframe(withRelativeStartTime: 1/4, relativeDuration: 1/4, animations: {
                viewToAnimate?.frame.origin.y = (viewToAnimate?.frame.origin.y)! - (position * 2)
            })
        }, completion: { completed in
            
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
