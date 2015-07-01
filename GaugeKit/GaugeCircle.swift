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
    func getCircleGauge(rotateAngle: Double) -> CAShapeLayer
}

extension Gauge: GaugeCircle {
    func getCircleGauge(rotateAngle: Double) -> CAShapeLayer {

        let gaugeLayer = CAShapeLayer()

        if bgLayer == nil {
            bgLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: bounds)
            bgLayer.frame = layer.bounds
            gaugeLayer.addSublayer(bgLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clearColor(), fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: bounds)

            ringLayer.frame = layer.bounds
//            gaugeLayer.addSublayer(ringLayer)
        }

        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            ringGradientLayer.startPoint = CGPointMake(1, 0.5)
            ringGradientLayer.endPoint = CGPointMake(-1, 0.5)
            ringGradientLayer.colors = [endColor.CGColor, startColor.CGColor]
            ringGradientLayer.frame = CGRectMake(0,0, layer.bounds.width, layer.bounds.height/2)
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }
        
        if ringGradientLayer2 == nil {
            ringGradientLayer2 = CAGradientLayer()
            ringGradientLayer2.startPoint = CGPointMake(1, 0.5)
            ringGradientLayer2.endPoint = CGPointMake(-1, 0.5)
            ringGradientLayer2.colors = [startColor.CGColor, endColor.CGColor]
            ringLayer2 = CAShapeLayer.getOval(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: startColor, fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: bounds)
            ringLayer2.frame = layer.bounds
            ringLayer2.bounds = CGRectMake(0, layer.bounds.height / 2, layer.bounds.width, layer.bounds.height)
            gaugeLayer.addSublayer(ringLayer2)
            ringGradientLayer2.frame = CGRectMake(0, layer.bounds.height / 2, layer.bounds.width, layer.bounds.height / 2)
            ringGradientLayer2.mask = ringLayer2
            gaugeLayer.addSublayer(ringGradientLayer2)
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
