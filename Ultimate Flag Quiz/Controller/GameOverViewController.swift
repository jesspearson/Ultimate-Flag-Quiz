//
//  GameOverViewController.swift
//  Ultimate Flag Quiz
//
//  Created by Pearson, Jessica (Tester) on 26/03/2019.
//  Copyright © 2019 Pearson, Jessica. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultText: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var finalScore : String?
    var lives : Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = finalScore
        if lives! > 0 {
            resultImage.image = #imageLiteral(resourceName: "winner")
            resultText.text = "You Win 🏁"
        }
        else {
            resultImage.image = #imageLiteral(resourceName: "sadface")
            resultText.text = "You Lost 🏴‍☠️"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
