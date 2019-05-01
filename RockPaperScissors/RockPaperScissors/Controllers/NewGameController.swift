//
//  NewGameController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/13/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum NewOrJoinedGame {
    case joined
    case new
}

class NewGameController {
    static let shared = NewGameController()
    
    var isHost = false
    var isFirstRound = true
    
    func newOrJoinedGame(method: NewOrJoinedGame) {
        switch method {
        case .new:
            break
        case .joined:
            break
        }
    }
}

