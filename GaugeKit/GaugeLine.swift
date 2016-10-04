//
//  Gauge.swift
//  SWGauge
//
//  Created by Petr Korolev on 02/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import QuartzCore


protocol GaugeLine {
    func getLineGauge(_ rotateAngle: Double) -> CAShapeLayer
}

extension Gauge: GaugeLine {
    func getLineGauge(_ rotateAngle: Double) -> CAShapeLayer {

        let gaugeLayer = CAShapeLayer()

        if bgLayer == nil {
            bgLayer = CAShapeLayer.getLine(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)
            bgLayer.frame = layer.bounds
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getLine(lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clear, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)
            ringLayer.frame = layer.bounds
        }

        if bgGradientLayer == nil {
            bgGradientLayer = CAGradientLayer()
            bgGradientLayer.startPoint = CGPoint(x: 0, y: 1)
            bgGradientLayer.endPoint = CGPoint(x: 1, y: 1)
            bgGradientLayer.colors = [_bgStartColor.cgColor, _bgEndColor.cgColor]
            bgGradientLayer.frame = layer.bounds
            bgGradientLayer.mask = bgLayer
            gaugeLayer.addSublayer(bgGradientLayer)
        }

        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            ringGradientLayer.startPoint = CGPoint(x: 0, y: 1)
            ringGradientLayer.endPoint = CGPoint(x: 1, y: 1)
            ringGradientLayer.colors = [startColor.cgColor, endColor.cgColor]
            ringGradientLayer.frame = layer.bounds
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }

        gaugeLayer.frame = layer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        if roundCap {
            ringLayer.lineCap = kCALineCapRound
            bgLayer.lineCap = kCALineCapRound
        } else {
            ringLayer.lineCap = kCALineCapSquare
            bgLayer.lineCap = kCALineCapSquare
        }
        if reverse {
            reverseX(gaugeLayer)
        }
        return gaugeLayer
    }
}
