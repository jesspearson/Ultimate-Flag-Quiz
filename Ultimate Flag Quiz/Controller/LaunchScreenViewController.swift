//
//  ViewController.swift
//  Ultimate Flag Quiz
//
//  Created by Pearson, Jessica (Tester) on 22/02/2019.
//  Copyright © 2019 Pearson, Jessica. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    


    
    @IBAction func startGameButton(_ sender: Any) {
        performSegue(withIdentifier: "startGame", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGame" {
            
            segue.destination as! StandardGameViewController
            
            //destinationVC.delegate = self  - - Do I need this?
        }
    }
    
    
}

