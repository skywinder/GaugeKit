//
//  UIColor+Blend.swift
//  SWGauge
//
//  Created by David Pelletier on 2015-03-06.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit

func + (left: UIColor, right: UIColor) -> UIColor {
    var leftRGBA = [CGFloat](repeating: 0.0, count: 4)
    var rightRGBA = [CGFloat](repeating: 0.0, count: 4)
    
    left.getRed(&leftRGBA[0], green: &leftRGBA[1], blue: &leftRGBA[2], alpha: &leftRGBA[3])
    right.getRed(&rightRGBA[0], green: &rightRGBA[1], blue: &rightRGBA[2], alpha: &rightRGBA[3])
    
    return UIColor(
        red: max(leftRGBA[0], rightRGBA[0]),
        green: max(leftRGBA[1], rightRGBA[1]),
        blue: max(leftRGBA[2], rightRGBA[2]),
        alpha: max(leftRGBA[3], rightRGBA[3])
    )
}

func * (left: CGFloat, right: UIColor) -> UIColor {
    var rightRGBA = [CGFloat](repeating: 0.0, count: 4)
    
    right.getRed(&rightRGBA[0], green: &rightRGBA[1], blue: &rightRGBA[2], alpha: &rightRGBA[3])
    
    return UIColor(
        red: rightRGBA[0] * left,
        green: rightRGBA[1] * left,
        blue: rightRGBA[2] * left,
        alpha: rightRGBA[3]
    )
}

func * (left: UIColor, right: CGFloat) -> UIColor {
    return right * left
}
