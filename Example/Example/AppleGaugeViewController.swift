
import UIKit
import GaugeKit

class AppleGaugeViewController: UIViewController {
    //@IBOutlet var scaleLabel: UILabel!
    @IBOutlet var gauge_in: Gauge!
    @IBOutlet var gauge_mid: Gauge!
    @IBOutlet var gauge_out: Gauge!
    
    
    @IBAction func sliderChanged(sender: UISlider) {
        gauge_in.rate = CGFloat(sender.value * 4)
        gauge_mid.rate = CGFloat(sender.value * 12)
        gauge_out.rate = CGFloat(sender.value * 12)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
