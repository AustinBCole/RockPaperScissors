//
//  MechanicsController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation
import UIKit



enum PlayerMethod: String, RawRepresentable {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

class MechanicsController {
    
    class func resolveGame(playerMethod: PlayerMethod, opponentMethod: PlayerMethod) -> (winningMethod: PlayerMethod, losingMethod: PlayerMethod)? {
        if playerMethod == opponentMethod {return nil}
        switch playerMethod {
        case .rock:
            if opponentMethod == .scissors {
                return (winningMethod: playerMethod, losingMethod: opponentMethod)
            } else {
                return (winningMethod: opponentMethod, losingMethod: playerMethod)
            }
        case .paper:
            if opponentMethod == .rock {
                return (winningMethod: playerMethod, losingMethod: opponentMethod)
            } else {
                return (winningMethod: opponentMethod, losingMethod: playerMethod)
            }
        case .scissors:
            if opponentMethod == .paper {
                return (winningMethod: playerMethod, losingMethod: opponentMethod)
            } else {
                return (winningMethod: opponentMethod, losingMethod: playerMethod)
            }
        }
    }
}
