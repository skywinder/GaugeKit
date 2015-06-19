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
public class GaugeHalf: Gauge {


    @IBInspectable var right: Bool = false {
        didSet {
            self.type = right ? GaugeType.Right : GaugeType.Left
            updateLayerProperties()
        }
    }

    override public func layoutSubviews() {

        super.layoutSubviews()

    }

    override func getGauge(rotateAngle: Double = 0) -> CALayer {
        var gaugeLayer = getHalfGauge(rotateAngle: rotateAngle)
        return gaugeLayer
    }

    func getHalfGauge(rotateAngle: Double? = 0) -> CAShapeLayer {

        let gaugeLayer = CAShapeLayer()

        //        let rotatedBounds = CGRectMake(10, 10, bounds.height, bounds.width)
        var newBounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.height, bounds.width * 2 - lineWidth)
        //        var newBounds = bounds
        if bgLayer == nil {
            bgLayer = CAShapeLayer.getOval(lineWidth, path: nil, strokeStart: 0, strokeEnd: 0.5, strokeColor: _bgStartColor,
                    fillColor: UIColor.clearColor(), shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSizeZero, bounds: newBounds, rotateAngle: M_PI_2, isCircle: isCircle)
            bgLayer.frame = layer.bounds
            bgLayer.position = CGPointMake(bgLayer.position.x + bounds.width - lineWidth, bgLayer.position.y)
        }

        if bgGradientLayer == nil {
            bgGradientLayer = CAGradientLayer()
            if isCircle && (layer.bounds.width < layer.bounds.height) {
                let adjust: CGFloat = (layer.bounds.height - layer.bounds.width) / 2 / layer.bounds.height
                bgGradientLayer.startPoint = CGPointMake(0.5, 1 - adjust)
                bgGradientLayer.endPoint = CGPointMake(0.5, adjust)
            } else {
                bgGradientLayer.startPoint = CGPointMake(0.5, 1)
                bgGradientLayer.endPoint = CGPointMake(0.5, 0)
            }
            bgGradientLayer.colors = [_bgStartColor.CGColor, _bgEndColor.CGColor]
            bgGradientLayer.frame = layer.bounds
            bgGradientLayer.mask = bgLayer
            gaugeLayer.addSublayer(bgGradientLayer)
        }

        if ringLayer == nil {
            ringLayer = CAShapeLayer.getOval(lineWidth, path: nil, strokeStart: 0, strokeEnd: 0.5, strokeColor: startColor,
                    fillColor: UIColor.clearColor(), shadowRadius: shadowRadius, shadowOpacity: shadowOpacity, shadowOffsset: CGSizeZero, bounds: newBounds, rotateAngle: M_PI_2, isCircle: isCircle)
            ringLayer.frame = layer.bounds
            ringLayer.position = CGPointMake(ringLayer.position.x + bounds.width - lineWidth, ringLayer.position.y)
        }

        if ringGradientLayer == nil {
            ringGradientLayer = CAGradientLayer()
            if isCircle && (layer.bounds.width < layer.bounds.height) {
                let adjust: CGFloat = (layer.bounds.height - layer.bounds.width) / 2 / layer.bounds.height
                ringGradientLayer.startPoint = CGPointMake(0.5, 1 - adjust)
                ringGradientLayer.endPoint = CGPointMake(0.5, adjust)
            } else {
                ringGradientLayer.startPoint = CGPointMake(0.5, 1)
                ringGradientLayer.endPoint = CGPointMake(0.5, 0)
            }
            ringGradientLayer.colors = [startColor.CGColor, _endColor.CGColor]
            ringGradientLayer.frame = layer.bounds
            ringGradientLayer.mask = ringLayer
            gaugeLayer.addSublayer(ringGradientLayer)
        }

        if roundCap {
            ringLayer.lineCap = kCALineCapRound
            bgLayer.lineCap = kCALineCapRound
        }

        gaugeLayer.frame = layer.bounds
        gaugeLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        gaugeLayer.transform = CATransform3DRotate(gaugeLayer.transform, CGFloat(rotateAngle!), 0, 0, 1)
        if reverse {
            reverseX(gaugeLayer)
        }

        if right {
            reverseY(gaugeLayer)
        }

        return gaugeLayer
    }
}
