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
    private var audioPlayer: AudioPlayer?
    
    //MARK: Other Properties
    var playerMethod: PlayerMethod?
    var opponentMethod: PlayerMethod?
    var deviceConnection: DeviceConnection?
    
    //MARK: IBOutlets
    @IBOutlet weak var winningImageView: UIImageView!
    @IBOutlet weak var winningImageViewTwo: UIImageView!
    @IBOutlet weak var winningImageViewThree: UIImageView!
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var tieGameLabel: UILabel!
    
    @IBOutlet weak var losingImageView: UIImageView!
    @IBOutlet weak var losingImageViewTwo: UIImageView!
    @IBOutlet weak var losingImageViewThree: UIImageView!
    
    @IBOutlet weak var powImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        audioPlayer = AudioPlayer()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        audioPlayer?.play()
        
        tieGameLabel.isHidden = true
        losingImageViewTwo.isHidden = true
        losingImageViewThree.isHidden = true
        winningImageViewTwo.isHidden = true
        winningImageViewThree.isHidden = true
        powImageView.isHidden = true
        playAgainButton.isHidden = true
        
        let randomMethodArray: Array<PlayerMethod> = [.rock, .paper, .scissors]
        
        let gameResults = MechanicsController.resolveGame(playerMethod: playerMethod ?? PlayerMethod.rock, opponentMethod: opponentMethod ?? randomMethodArray[Int.random(in: 0 ..< 3)])
        
        winningImageView.image = UIImage(named: gameResults.winningMethod.rawValue)
        winningImageViewTwo.image = UIImage(named: gameResults.winningMethod.rawValue)
        winningImageViewThree.image = UIImage(named: gameResults.winningMethod.rawValue)
        
        losingImageView.image = UIImage(named: gameResults.losingMethod.rawValue)
        losingImageViewTwo.image = UIImage(named: gameResults.losingMethod.rawValue)
        losingImageViewThree.image = UIImage(named: gameResults.losingMethod.rawValue)
        
        powImageView.image = UIImage(named: "POW! with transparent background")
        
        
        
        if gameResults.tie == true {
            NSLog("tieAnimation called")
            tieAnimation()
            return
        } else {
            NSLog("victoryAnimation called")
            victoryAnimation()
        }
        
    }
    
    //MARK: IBActions
    @IBAction func playAgainButtonTapped(_ sender: Any) {
        //I don't need to make isHost persistent through the app because I am using `self.dismiss` here
        self.dismiss(animated: true) {
        }
    }
    
    
    //MARK: Private Methods
    private func victoryAnimation() {
        let animationDuration = 3.0
        let position: CGFloat = 100.0
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.winningImageView?.frame.origin.x = self.winningImageView.frame.origin.x + position
                self.losingImageView?.frame.origin.x = self.losingImageView.frame.origin.x - position
            })
        }, completion: { completed in
            if completed {
                self.losingImageViewTwo.isHidden = false
                self.winningImageViewTwo.isHidden = false
                self.losingImageView.isHidden = true
                self.winningImageView.isHidden = true
            }
        })
        UIView.animateKeyframes(withDuration: 1.0, delay: animationDuration + 2.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                
                self.winningImageViewTwo.frame.origin.x = (self.winningImageViewThree?.frame.origin.x)!
                self.losingImageViewTwo.frame.origin.x = self.losingImageViewThree.frame.origin.x
            })
        }, completion: { completed in
            if completed {
                self.winningImageViewThree.isHidden = false
                self.losingImageViewThree.isHidden = false
                self.winningImageViewTwo.isHidden = true
                self.losingImageViewTwo.isHidden = true
                
                self.powImageView.isHidden = false
            }
        })
        UIView.animateKeyframes(withDuration: 1.0, delay: animationDuration + 3.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                
                self.losingImageViewThree.frame.origin.x = self.losingImageViewTwo.frame.origin.x + 500
                self.losingImageViewThree.frame.origin.y = self.losingImageViewThree.frame.origin.y - 750
            })
        }, completion: { completed in
            if completed {
                self.losingImageViewThree.isHidden = true
                self.playAgainButton.isHidden = false
                
                if UIImage(named: (self.playerMethod?.rawValue)!) == self.winningImageView.image {
                    self.tieGameLabel.text = "You Win!"
                    self.audioPlayer?.play(url: Bundle.main.url(forResource: "cheering", withExtension: "wav"))
                } else if UIImage(named: (self.playerMethod?.rawValue)!) == self.losingImageView.image {
                    self.tieGameLabel.text = "You Lose!"
                    self.audioPlayer?.play(url: Bundle.main.url(forResource: "booing", withExtension: "mp3"))
                }
                self.tieGameLabel.isHidden = false
            }
        })
    }
    
    private func tieAnimation() {
        
        let animationDuration = 3.0
        let position: CGFloat = 100.0
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                self.winningImageView?.frame.origin.x = self.winningImageView.frame.origin.x + position
                self.losingImageView?.frame.origin.x = self.losingImageView.frame.origin.x - position
            })
        }, completion: { completed in
            if completed {
                self.losingImageViewTwo.isHidden = false
                self.winningImageViewTwo.isHidden = false
                self.losingImageView.isHidden = true
                self.winningImageView.isHidden = true
            }
        })
        UIView.animateKeyframes(withDuration: 1.0, delay: animationDuration + 2.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3, animations: {
                
                self.winningImageViewTwo.frame.origin.x = (self.winningImageViewTwo?.frame.origin.x)! + position
                self.losingImageViewTwo.frame.origin.x = self.losingImageViewTwo.frame.origin.x - 92
            })
        }, completion: { completed in
            if completed {
                self.winningImageViewThree.isHidden = false
                self.losingImageViewThree.isHidden = false
                self.winningImageViewTwo.isHidden = true
                self.losingImageViewTwo.isHidden = true
                self.tieGameLabel.isHidden = false
                self.playAgainButton.isHidden = false
                
                self.audioPlayer?.play(url: Bundle.main.url(forResource: "disappointed", withExtension: "mp3"))
                
            }
        })
        
    }

    
}
