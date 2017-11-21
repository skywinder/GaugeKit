//
//  UIColor+Blend.swift
//  SWGauge
//
//  Created by David Pelletier on 2015-03-06.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit

func + (left: UIColor, right: UIColor) -> UIColor {
    
    var lRed : CGFloat = 0
    var lGreen : CGFloat = 0
    var lBlue : CGFloat = 0
    var lAlpha: CGFloat = 0
    left.getRed(&lRed, green: &lGreen, blue: &lBlue, alpha: &lAlpha)
    
    var rRed : CGFloat = 0
    var rGreen : CGFloat = 0
    var rBlue : CGFloat = 0
    var rAlpha: CGFloat = 0
    right.getRed(&rRed, green: &rGreen, blue: &rBlue, alpha: &rAlpha)
    
    return UIColor(
        red: max(lRed, rRed),
        green: max(lGreen, rGreen),
        blue: max(lBlue, rBlue),
        alpha: max(lAlpha, rAlpha)
    )
}

func * (left: CGFloat, right: UIColor) -> UIColor {
    var rRed : CGFloat = 0
    var rGreen : CGFloat = 0
    var rBlue : CGFloat = 0
    var rAlpha: CGFloat = 0
    right.getRed(&rRed, green: &rGreen, blue: &rBlue, alpha: &rAlpha)
    
    return UIColor(
        red: rRed * left,
        green: rGreen * left,
        blue: rBlue * left,
        alpha: rAlpha
    )
}

func * (left: UIColor, right: CGFloat) -> UIColor {
    return right * left
}
