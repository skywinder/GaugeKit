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
public class Gauge: UIView {

    enum GaugeType: Int {
        case Circle = 0
        case Left
        case Right
        case Top
        case Bottom
        case Custom
    }

    @IBInspectable var startColor: UIColor = UIColor.greenColor() {
        didSet {
            updateLayerProperties()
        }
    }

    /// default is nil: endColor is same as startColor
    @IBInspectable var endColor: UIColor? {
        didSet {
            updateLayerProperties()
        }
    }
    var _endColor: UIColor {
        get {
            if let endColor = endColor {
                return endColor
            } else {
                return startColor
            }
        }
        set {
            endColor = newValue
        }
    }
    @IBInspectable var bgColor: UIColor? {
        didSet {
            updateLayerProperties()
        }
    }

    var _bgStartColor: UIColor {
        set {
            bgColor = newValue
        }
        get {
            if let bgColor = bgColor {
                return bgColor.colorWithAlphaComponent(bgAlpha)
            } else {
                return startColor.colorWithAlphaComponent(bgAlpha)
            }
        }
    }

    var _bgEndColor: UIColor {
        set {
            bgColor = newValue
        }
        get {
            if let bgColor = bgColor {
                return bgColor.colorWithAlphaComponent(bgAlpha)
            } else {
                return _endColor.colorWithAlphaComponent(bgAlpha)
            }
        }
    }
    @IBInspectable var bgAlpha: CGFloat = 0.4 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var rotate: Double = 0 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var customColors: Bool = true {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable public var reverse: Bool = true {
        didSet {
            resetLayers()
            updateLayerProperties()
        }
    }

    /// Default is equal to #lineWidth. Set it to 0 to remove round edges
    @IBInspectable public var roundCap: Bool = true {
        didSet {
            updateLayerProperties()
        }
    }

    var type: GaugeType = .Circle

/// Percantage of filling Gauge: 0..10
    @IBInspectable public var rate: CGFloat = 9 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var isCircle: Bool = false {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable var lineWidth: CGFloat = 15.0 {
        didSet {
            updateLayerProperties()
        }
    }

/// Main gauge layer
    var gaugeLayer: CALayer!
/// Colored layer, depends from scale
    var ringLayer: CAShapeLayer!
/// background for ring layer
    var bgLayer: CAShapeLayer!
/// ring gradient layer
    var ringGradientLayer: CAGradientLayer!
/// background gradient
    var bgGradientLayer: CAGradientLayer!


    func getGauge(rotateAngle: Double = 0) -> CALayer {
        preconditionFailure("This method must be overridden")
    }

    func updateLayerProperties() {
        backgroundColor = UIColor.clearColor()

        if (ringLayer != nil) {

            switch (type) {
            case .Left, .Right:
                let percanage = rate / 20 % 0.5
                ringLayer.strokeEnd = (rate >= 10 ? 0.5 : percanage + ((rate != 0 && percanage == 0) ? 0.5 : 0))
            case .Circle, .Custom:
                ringLayer.strokeEnd = rate / 10
            default:
                ringLayer.strokeEnd = rate / 10

            }

            var strokeColor = UIColor.lightGrayColor()
            //TODO: replace pre-defined colors with array of user-defined colors
            //TODO: and split them proportionally in whole sector
            if !customColors {
                switch (rate / 10) {
                case let r where r >= 0.75:
                    strokeColor = UIColor(hue:
                    112.0 / 360.0, saturation:
                    0.39, brightness: 0.85,
                            alpha: 1.0)
                case let r where r >= 0.5:
                    strokeColor = UIColor(hue:
                    208.0 / 360.0, saturation:
                    0.51, brightness: 0.75,
                            alpha: 1.0)
                case let r where r >= 0.25:
                    strokeColor = UIColor(hue: 40.0 / 360.0, saturation: 0.39,
                            brightness: 0.85, alpha: 1.0)
                default:
                    strokeColor = UIColor(hue:
                    359.0 / 360.0, saturation:
                    0.48, brightness: 0.63,
                            alpha: 1.0)
                }
                ringLayer.strokeColor = strokeColor.CGColor
            } else {
                ringLayer.strokeColor = startColor.CGColor
            }

        }
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateLayerProperties()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayerProperties()
    }

    public override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        updateLayerProperties()
    }

    func reverseY(layer: CALayer) {
//        layer.transform = CATransform3DScale(CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1), -1, 1, 1)
        layer.transform = CATransform3DScale(layer.transform, -1, 1, 1)

    }

    func reverseX(layer: CALayer) {
//        layer.transform = CATransform3DScale(CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1), 1, -1, 1)
        layer.transform = CATransform3DScale(layer.transform, 1, -1, 1)

    }

    func resetLayers() {
        layer.sublayers = nil
        bgLayer = nil
        ringLayer = nil
        ringGradientLayer = nil
        bgGradientLayer = nil
    }

    public override func layoutSubviews() {
        resetLayers()
        gaugeLayer = getGauge(rotateAngle: rotate / 10 * M_PI)
        layer.addSublayer(gaugeLayer)
        updateLayerProperties()
    }
}
