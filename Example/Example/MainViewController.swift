//
//  MainViewController.swift
//  SWGauge
//
//  Created by Petr Korolev on 21/05/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import GaugeKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientGauge.colorsArray = [UIColor.red, UIColor.orange, UIColor.yellow ,UIColor.green]
    }

    @IBOutlet var allGauges: [Gauge]!
    @IBOutlet var gradientGauge: Gauge!
    @IBOutlet var gaugeSmall: Gauge!
    @IBOutlet var leftGauge: Gauge!
    @IBOutlet var rightGauge: Gauge!
    @IBOutlet var lineGauge: Gauge!
    @IBAction func sliderChanged(_ sender: UISlider) {
        gradientGauge.rate = CGFloat(sender.value)
        gaugeSmall.rate = CGFloat(sender.value)
        leftGauge.rate = CGFloat(sender.value)
        rightGauge.rate = CGFloat(sender.value)
        lineGauge.rate = CGFloat(sender.value)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func animateAction(_ sender: AnyObject) {
        for gauge in self.allGauges {
            let newRate : CGFloat = gauge.rate == 0.0 ? 10.0 : 0.0

            gauge.animateRate(1.0, newValue: newRate) { (finished) in
                if (finished) {print("\(gauge.type) animation completed !")}
            }
        }
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        gradientGauge.reverse = sender.isOn
        leftGauge.reverse = sender.isOn
        rightGauge.reverse = sender.isOn
        lineGauge.reverse = sender.isOn

    }
}
