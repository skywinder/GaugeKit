//
//  Gauge.swift
//  SWGauge
//
//  Created by Petr Korolev on 02/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
public class GaugeCircle: Gauge {

    override public func layoutSubviews() {

        super.layoutSubviews()
    }

    override func getGauge(rotateAngle: Double = 0) -> CALayer {

        let gaugeLayer = CAShapeLayer()

        if bgLayer == nil {
            bgLayer = CAShapeLayer.getOval(lineWidth, path: nil, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: bounds)
            bgLayer.frame = layer.bounds
            gaugeLayer.addSublayer(bgLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, path: nil, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clearColor(), fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: bounds)

            ringLayer.frame = layer.bounds
            gaugeLayer.addSublayer(ringLayer)
        }
        gaugeLayer.frame = layer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Rotate it in 90° CCW to make start position from the top
        gaugeLayer.transform = CATransform3DRotate(gaugeLayer.transform, CGFloat(rotateAngle * 2 - M_PI_2), 0, 0, 1)

        if roundCap {
            ringLayer.lineCap = kCALineCapRound
            bgLayer.lineCap = kCALineCapRound
        }

        if reverse {
            reverseX(gaugeLayer)
        }
        return gaugeLayer
    }


}
