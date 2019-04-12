//
//  GameplayViewController+LoadingUI.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/15/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit


extension DriverWorkViewController {
    
    private func createIndeterminateLoadingView() {
        if loadingView == nil {
            loadingView = IndeterminateLoadingView(frame: CGRect(x: view.center.x - 144, y: view.center.y - 290, width: 300, height: 300))
        }
    }
    private func addToSubview() {
        if isSubviewOfSuperview == false {
            view.addSubview(loadingView!)
        }
    }
    public func animateLoadingView() {
        createIndeterminateLoadingView()
        addToSubview()
        if !(loadingView?.isAnimating)! {
            loadingView?.startAnimating()
            isSubviewOfSuperview = true
        }
    }
    public func stopAnimatingLoadingView(){
        loadingView?.stopAnimating()
        loadingView?.removeFromSuperview()
        isSubviewOfSuperview = false
    }
    
}
