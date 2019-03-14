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
    func connectedDevicesChanged(manager: DeviceConnection, connectedDevices: [String])
}

protocol DeviceMethodDelegate {
    func methodSelected(manager: DeviceConnection, method: PlayerMethod)

}
protocol DeviceIsReadyDelegate {
    func opponentIsRead(manager: DeviceConnection, isReady: Bool)
}
