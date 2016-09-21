//
//  Gauge.swift
//  SWGauge
//
//  Created by Petr Korolev on 02/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import QuartzCore


protocol GaugeCircle {
    func getCircleGauge(_ rotateAngle: Double) -> CAShapeLayer
}

extension Gauge: GaugeCircle {
    func getCircleGauge(_ rotateAngle: Double) -> CAShapeLayer {

        let gaugeLayer = CAShapeLayer()

        if bgLayer == nil {
            bgLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)
            bgLayer.frame = layer.bounds
            gaugeLayer.addSublayer(bgLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clear, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)

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
            reverseY(gaugeLayer)
        }
        return gaugeLayer
    }
}
