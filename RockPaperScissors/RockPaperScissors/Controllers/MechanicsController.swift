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
    
    //TODO: Change the nexted if statements into a nested switch statement. I was getting a bug where there was no animation happening every once in a while because I did not have an if statement for if opponentMethod == .rock. I had .paper twice. A switch statement inside of a switch statement would have been much safer.
    class func resolveGame(playerMethod: PlayerMethod, opponentMethod: PlayerMethod) -> (winningMethod: PlayerMethod, losingMethod: PlayerMethod, tie: Bool) {
        switch playerMethod {
        case .rock:
            switch opponentMethod {
            case .rock:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            case .paper:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            case .scissors:
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            }
        case .paper:
            switch opponentMethod {
            case .rock:
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            case .paper:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            case .scissors:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            }
        case .scissors:
            switch opponentMethod {
            case .rock:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: false)
            case .paper:
                return (winningMethod: playerMethod, losingMethod: opponentMethod, tie: false)
            case .scissors:
                return (winningMethod: opponentMethod, losingMethod: playerMethod, tie: true)
            }
        }
    }
}
