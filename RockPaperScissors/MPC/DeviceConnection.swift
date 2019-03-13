//
//  DeviceConnectionController.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class DeviceConnection: NSObject {
    lazy var session: MCSession = {
        let session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        return session
    }()
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private let ColorServiceType = "example-color"
    
    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
    
    private let serviceAdvertiser: MCNearbyServiceAdvertiser
    private let serviceBrowser: MCNearbyServiceBrowser
    
    var deviceDelegate: DeviceConnectionDelegate?
    var methodDelegate: DeviceMethodDelegate?
    
    override init() {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: ColorServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: ColorServiceType)
        
        super.init()
        serviceAdvertiser.delegate = self
        serviceBrowser.delegate = self
    }
    
    deinit {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    /**
     Sends the coordinates of the device's location to the other device(s) in the session. There must be at least one connected peer in the session for the coordinates to be sent.
     
     - Parameter coordinates: the CLLocation of the device's current location.
     */
    func send(method: PlayerMethod) {
        guard let data = method.rawValue.data(using: .utf8) else {return}
        NSLog("%@", "sendMethod: \(method.rawValue) to \(session.connectedPeers.count) peers")
        if session.connectedPeers.count > 0 {
            do {
                try self.session.send(data, toPeers: session.connectedPeers, with: .reliable)
            } catch {
                NSLog("%@", "Error for sending: \(error)")
            }
        }
    }
    
    ///Start advertising to nearby peers.
    func startAdvertising() {
        self.serviceAdvertiser.startAdvertisingPeer()
    }
    ///Stop broadcasting to nearby peers.
    func stopAdvertising() {
        self.serviceAdvertiser.stopAdvertisingPeer()
    }
    ///Start browsing for nearby peers.
    func startBrowsing() {
        self.serviceBrowser.startBrowsingForPeers()
    }
    ///Stop browsing for nearby peers.
    func stopBrowsing() {
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
}

extension DeviceConnection: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    //The device will automatically accept the invitation from peer.
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
    
    
}

extension DeviceConnection: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    //The device will automatically invite all found peers to a session
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
        browser.invitePeer(peerID, to: self.session, withContext: nil, timeout: 10)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
    
    
}

extension DeviceConnection: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.rawValue)")
        self.deviceDelegate?.connectedDevicesChanged(connectedDevices: session.connectedPeers.map{$0.displayName})
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveData: \(data)")
        var methodString = ""
        do {
            methodString = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! String
        } catch {
            NSLog("Error decoding coordinates: \(error)")
        }
        let usedMethod = MechanicsController().methodChosenByOpponent(methodString: methodString)
        self.methodDelegate?.methodSelected(method: usedMethod)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        NSLog("%@", "didReceiveStream")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        NSLog("%@", "didStartReceivingResourceWithName")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
}
