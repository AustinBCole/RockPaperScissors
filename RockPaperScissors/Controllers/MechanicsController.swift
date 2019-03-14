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
}
