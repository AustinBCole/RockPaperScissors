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
    
    func methodChosenByOpponent(methodString: String) -> PlayerMethod {
        if methodString == PlayerMethod.paper.rawValue {
            return PlayerMethod.paper
        } else if methodString == PlayerMethod.scissors.rawValue {
            return PlayerMethod.scissors
        }
        return PlayerMethod.rock
    }
    
    class func resolveGame(playerMethod: PlayerMethod, opponentMethod: PlayerMethod) -> (winningMethod: PlayerMethod, losingMethod: PlayerMethod, tie: Bool)? {
        if playerMethod == opponentMethod {return nil}
        switch playerMethod {
        case .rock:
            if opponentMethod == .scissors {
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            } else if opponentMethod == .paper {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            } else if opponentMethod == .paper {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            }
        case .paper:
            if opponentMethod == .rock {
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            } else if opponentMethod == .scissors {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            } else if opponentMethod == .paper {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            }
        case .scissors:
            if opponentMethod == .paper {
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            } else if opponentMethod == .rock {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            } else if opponentMethod == .scissors {
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            }
        }
        return nil
    }
}
