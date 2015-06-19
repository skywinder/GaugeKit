//
//  CAShapeLayer+oval.swift
//  SWGauge
//
//  Created by Petr Korolev on 03/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import Foundation


extension CAShapeLayer {
    class func getOval(lineWidth: CGFloat,
                       path: CGPathRef?,
                       strokeStart: CGFloat,
                       strokeEnd: CGFloat,
                       strokeColor: UIColor,
                       fillColor: UIColor,
                       shadowRadius: CGFloat,
                       shadowOpacity: CGFloat,
                       shadowOffsset: CGSize,
                       bounds: CGRect? = nil,
                       rotateAngle: Double? = nil,
                       anchorPoint: CGPoint? = nil,
                       isCircle: Bool = true

    ) -> CAShapeLayer {

        let arc = CAShapeLayer()
        if let bounds = bounds {
            let rect = CGRectInset(bounds, CGFloat(lineWidth / 2.0), CGFloat(lineWidth / 2.0))
            if isCircle {
                let arcDiameter: CGFloat = min(bounds.width, bounds.height) - 2 * lineWidth
                let X = CGRectGetMidX(bounds)
                let Y = CGRectGetMidY(bounds)
                arc.path = UIBezierPath(ovalInRect: CGRectMake((X - (arcDiameter / 2)), (Y - (arcDiameter / 2)), arcDiameter, arcDiameter)).CGPath
            } else {
                arc.path = UIBezierPath(ovalInRect: rect).CGPath
            }
        } else {
            arc.path = path
        }

        arc.lineWidth = lineWidth

        arc.strokeStart = strokeStart

        arc.strokeColor = strokeColor.CGColor
        arc.fillColor = fillColor.CGColor
        arc.shadowColor = UIColor.blackColor().CGColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = Float(shadowOpacity)
        arc.shadowOffset = shadowOffsset

        if let anchorPoint = anchorPoint {
            arc.anchorPoint = anchorPoint
        }
        if let rotateAngle = rotateAngle {
            arc.transform = CATransform3DRotate(arc.transform, CGFloat(rotateAngle), 0, 0, 1)
        }

        arc.strokeEnd = strokeEnd
        return arc
    }
}
