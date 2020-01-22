import UIKit

//MARK: Properties
class ViewController: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    @IBOutlet weak var Num_Shots: UILabel!
    let model = ShotCountModel()
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func Shot_Result(_ sender: UIButton) {
        Result.adjustsFontSizeToFitWidth = true
        Result.minimumScaleFactor = 0.2
        Result.numberOfLines = 0
        
        if sender.tag == 1{ //this is for made shots
            model.addShot(success: true)
            Num_Shots.text = model.generateRatio()
        }
        else if sender.tag == 2{ //this is for missed shots
            model.addShot(success: false)
            Num_Shots.text = model.generateRatio()
        }
        else if sender.tag == 3{ //this is for finish
            model.finishShooting()
            Num_Shots.text = model.generateRatio()
            Result.text = model.generateText()
            model.resetShots()
        }
        else if sender.tag == 4{ //this is for reset
            model.resetShots()
            Num_Shots.text = model.generateRatio()
            Result.text = model.generateText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
