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
            bgLayer = CAShapeLayer.getOval(lineWidth: lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: _bgStartColor, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)
            bgLayer.frame = layer.bounds
            gaugeLayer.addSublayer(bgLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth: lineWidth, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clear, fillColor: UIColor.clear, shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSize.zero, bounds: bounds)

            ringLayer.frame = layer.bounds
//            gaugeLayer.addSublayer(ringLayer)
        }

        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            if isCircle && (layer.bounds.width < layer.bounds.height) {
                let adjust: CGFloat = (layer.bounds.height - layer.bounds.width) / 2 / layer.bounds.height
                ringGradientLayer.startPoint = CGPoint(x: 0.5, y: 1 - adjust)
                ringGradientLayer.endPoint = CGPoint(x: 0.5, y: adjust)
            } else {
                ringGradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
                ringGradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
            }
            ringGradientLayer.colors = [startColor.cgColor, endColor.cgColor, UIColor.red.cgColor]
            ringGradientLayer.frame = layer.bounds
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }

        gaugeLayer.frame = layer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        // Rotate it in 90° CCW to make start position from the top
        gaugeLayer.transform = CATransform3DRotate(gaugeLayer.transform, CGFloat(rotateAngle * 2 - Double.pi/2), 0, 0, 1)

        if roundCap {
            ringLayer.lineCap = CAShapeLayerLineCap.round
            bgLayer.lineCap = CAShapeLayerLineCap.round
        }

        if reverse {
            reverseY(layer: gaugeLayer)
        }
        return gaugeLayer
    }
}
