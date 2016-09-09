//
//  AppleGaugeViewController.swift
//  Example
//
//  Created by Petr Korolev on 19/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit
import GaugeKit

class AppleGaugeViewController: UIViewController {
    //    @IBOutlet var scaleLabel: UILabel!
    @IBOutlet var gauge_in: Gauge!
    @IBOutlet var gauge_mid: Gauge!
    @IBOutlet var gauge_out: Gauge!
    @IBAction func sliderChanged(_ sender: UISlider) {
        gauge_in.rate = CGFloat(sender.value * 4)
        gauge_mid.rate = CGFloat(sender.value * 8)
        gauge_out.rate = CGFloat(sender.value * 12)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
