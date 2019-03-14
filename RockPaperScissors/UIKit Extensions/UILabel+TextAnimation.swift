//
//  UILabel+TextAnimation.swift
//  RockPaperScissors
//
//  Created by Austin Cole on 3/12/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit
import CoreGraphics

extension UILabel {
    func animateText() {
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform().scaledBy(x: 5, y: 5)
        }
    }
}
