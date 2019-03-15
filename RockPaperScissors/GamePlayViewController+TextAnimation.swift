//
//  UILabel+TextAnimation.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit
import CoreGraphics

extension GamePlayViewController {
    func animateText(textLayer: CATextLayer) {
        animation(textLayer: textLayer)
    }
    func animation(textLayer: CATextLayer) {
        let duration: TimeInterval = 0.5
        textLayer.fontSize = 100
        let fontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        fontSizeAnimation.fromValue = 84
        fontSizeAnimation.toValue = 100
        fontSizeAnimation.duration = duration
        textLayer.add(fontSizeAnimation, forKey: nil)
    }
    func configureTextLayer(textLayer: CATextLayer) {
        textLayer.fontSize = 60
        textLayer.frame = timeLabel.frame
        textLayer.alignmentMode = .center
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.contentsScale = UIScreen.main.scale
        view.layer.addSublayer(textLayer)
    }
}
