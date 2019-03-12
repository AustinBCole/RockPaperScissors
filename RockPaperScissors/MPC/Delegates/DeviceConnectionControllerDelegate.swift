//
//  DeviceConnectionControllerDelegate.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol DeviceConnectionDelegate {
    func connectedDevicesChanged()
}

protocol DeviceMethodDelegate {
    func methodSelected(method: PlayerMethod)

}
