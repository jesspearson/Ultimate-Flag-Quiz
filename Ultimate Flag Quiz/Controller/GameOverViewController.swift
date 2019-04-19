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
    
    
    var finalScore : String?
    var lives : Int?
    var totalQuestions : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        if lives! > 0 {
            resultImage.image = #imageLiteral(resourceName: "trophy")
            resultText.text = "Final Score: \(finalScore!)/\(totalQuestions!)"
        }
        else {
            resultImage.image = #imageLiteral(resourceName: "game-over")
            resultText.text = "Final Score: \(finalScore!)/\(totalQuestions!)"
        }
    }
    
    @IBAction func playAgainPressed(_ sender: Any) {
        performSegue(withIdentifier: "playAgain", sender: self)
    }
    
    @IBAction func mainMenuPressed(_ sender: Any) {
        performSegue(withIdentifier: "returnToMainMenu", sender: self)
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
