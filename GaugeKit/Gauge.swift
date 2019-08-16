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
        case Line
        case Custom
    }

    @IBInspectable public var startColor: UIColor = UIColor.green {
        didSet {
            resetLayers()
            updateLayerProperties()
        }
    }

    /// default is nil: endColor is same as startColor
    @IBInspectable public var endColor: UIColor {
        get {
            if let _endColor = _endColor {
                return _endColor
            } else {
                return UIColor.red
            }
        }
        set {
            _endColor = newValue
        }
    }
    private var _endColor: UIColor? {
        didSet {
            resetLayers()
            updateLayerProperties()
        }
    }
    @IBInspectable public var bgColor: UIColor? {
        didSet {
            updateLayerProperties()
            setNeedsLayout()
        }
    }

    internal var _bgStartColor: UIColor {
        get {
            if let bgColor = bgColor {
                return bgColor.withAlphaComponent(bgAlpha)
            } else {
                return startColor.withAlphaComponent(bgAlpha)
            }
        }
    }

    internal var _bgEndColor: UIColor {
        get {
            if let bgColor = bgColor {
                return bgColor.withAlphaComponent(bgAlpha)
            } else {
                return endColor.withAlphaComponent(bgAlpha)
            }
        }
    }
    @IBInspectable public var bgAlpha: CGFloat = 0.2 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable public var rotate: Double = 0 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable public var colorsArray: Bool = false {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable public var shadowRadius: CGFloat = 0 {
        didSet {
            updateLayerProperties()
        }
    }
    @IBInspectable public var shadowOpacity: Float = 0.5 {
        didSet {
            updateLayerProperties()
        }
    }

    @IBInspectable public var reverse: Bool = false {
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

    var type: GaugeType = .Circle {
        didSet {
            resetLayers()
            updateLayerProperties()
        }
    }

    /// Convenience property to setup type variable from IB
    @IBInspectable var gaugeTypeInt: Int {

        get {
            return type.rawValue
        }
        set(newValue) {
            if let newType = GaugeType(rawValue: newValue) {
                type = newType
            } else {
                type = .Circle
            }
        }
    }

    /// This value specify rate value for 100% filled gauge. Default is 10.
    ///i.e. with rate = 10 gauge is 100% filled.
    @IBInspectable public var maxValue: CGFloat = 10 {
        didSet {
            updateLayerProperties()
        }
    }
    /// percantage of filled Gauge. 0..maxValue.
    @IBInspectable public var rate: CGFloat = 8 {
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
    
    @IBInspectable var thinLineWidth: CGFloat = 1.0 {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable var thinBG: Bool = false {
        didSet {
            updateLayerProperties()
        }
    }
    
    @IBInspectable var thinBGColor: UIColor = .white {
        didSet {
            updateLayerProperties()
        }
    }

/// Main gauge layer
    var gaugeLayer: CALayer!
/// Colored layer, depends from scale
    var ringLayer: CAShapeLayer!
    var ringLayer2:CAShapeLayer!
/// background for ring layer
    var bgLayer: CAShapeLayer!
/// ring gradient layer
    var ringGradientLayer: CAGradientLayer!
/// additional ring gradient layer for circle
    var ringGradientLayer2: CAGradientLayer!
/// background gradient
    var bgGradientLayer: CAGradientLayer!
/// additional background gradient layer for circle
    var bgGradientLayer2: CAGradientLayer!

    func getGauge(rotateAngle: Double = 0) -> CAShapeLayer {
        switch type {
        case .Left, .Right:
            return getHalfGauge(rotatengle: rotateAngle)
        case .Circle:
            return getCircleGauge(rotateAngle: rotateAngle)
        case .Line:
            return getLineGauge(rotateAngle: rotateAngle)
        default:
            return getCircleGauge(rotateAngle: rotateAngle)
        }
    }

    func updateLayerProperties() {
        backgroundColor = UIColor.clear

        if (ringLayer != nil) {

            switch (type) {
            case .Left, .Right:
                // For Half gauge you have to fill 50% of circle and round it wisely.
                let percentage = (rate / 2 / maxValue).truncatingRemainder(dividingBy: 0.5)
                ringLayer.strokeEnd = (rate >= maxValue ? 0.5 : percentage + ((rate != 0 && percentage == 0) ? 0.5 : 0))
            case .Circle, .Custom:
                ringLayer.strokeEnd = rate / maxValue
            default:
                ringLayer.strokeEnd = rate / maxValue

            }

            var strokeColor = UIColor.lightGray
            //TODO: replace pre-defined colors with array of user-defined colors
            //TODO: and split them proportionally in whole sector
            
            //colorsArray = [.red, .green, .blue]
            
            if colorsArray {
                switch (rate / maxValue) {
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
                if (ringGradientLayer != nil) {
                    let color1 = startColor
                    let color2 = endColor
                    let colors: Array <AnyObject> = [color1.cgColor, color2.cgColor]
                    ringGradientLayer.colors = colors
                } else {
                    ringLayer.strokeColor = strokeColor.cgColor
                }
            } else {
                ringLayer.strokeColor = startColor.cgColor
            }

        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        updateLayerProperties()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayerProperties()
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateLayerProperties()
    }

    func reverseX(layer: CALayer) {
//        layer.transform = CATransform3DScale(CATransform3DMakeRotation(CGFloat(M_PI_2), 0, 0, 1), -1, 1, 1)
        layer.transform = CATransform3DScale(layer.transform, -1, 1, 1)

    }

    func reverseY(layer: CALayer) {
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
        gaugeLayer = getGauge(rotateAngle: rotate / 10 * Double.pi)
        layer.addSublayer(gaugeLayer)
        updateLayerProperties()
    }
}


