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

    }

    @IBOutlet var allGauges: [Gauge]!
//    @IBOutlet var scaleLabel: UILabel!
    @IBOutlet var gauge: Gauge!
    @IBOutlet var gaugeSmall: Gauge!
    @IBOutlet var leftGauge: Gauge!
    @IBOutlet var rightGauge: Gauge!
    @IBOutlet var lineGauge: Gauge!
    @IBAction func sliderChanged(sender: UISlider) {
        gauge.rate = CGFloat(sender.value)
        gaugeSmall.rate = CGFloat(sender.value)
        leftGauge.rate = CGFloat(sender.value)
        rightGauge.rate = CGFloat(sender.value)
        lineGauge.rate = CGFloat(sender.value)

//        scaleLabel.text = "\(sender.value)"
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

    }

    @IBAction func animateAction(sender: AnyObject) {

//   UIView.beginAnimations(nil, context: nil)
//        UIView.setAnimationDuration(5.0)
//        for gauge in self.allGauges {
//            gauge.rate = gauge.rate == 0.0 ? 10 : 0
//        }
//        UIView.commitAnimations()
//
        UIView.animateWithDuration(NSTimeInterval(5.0), animations: {
            () -> Void in
            print(self.allGauges.count)
            for gauge in self.allGauges {
                gauge.rate = gauge.rate == 0.0 ? 10 : 0
//                gauge.rate = CGFloat(arc4random() % 10)
            }
            return
        })

    }

    @IBAction func switchChanged(sender: UISwitch) {
        gauge.reverse = sender.on
        leftGauge.reverse = sender.on
        rightGauge.reverse = sender.on
        lineGauge.reverse = sender.on

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
