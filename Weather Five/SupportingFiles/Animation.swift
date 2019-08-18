//
//  Animation.swift
//  Weather Five
//
//  Created by Vova SKR on 17/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import Foundation
import UIKit


class SimpleAnimation {
    
    func animationLabel (view: UILabel) {
        UIView.animateKeyframes(withDuration: 5, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/16, animations: {
                view.layer.opacity = 1
            })
            UIView.addKeyframe(withRelativeStartTime: 7/8, relativeDuration: 1/16, animations: {
                view.layer.opacity = 0
            })
        }, completion: nil)
    }
}
