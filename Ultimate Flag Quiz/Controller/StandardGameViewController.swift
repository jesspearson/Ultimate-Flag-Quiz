//
//  StandardGameViewController.swift
//  Ultimate Flag Quiz
//
//  Created by Pearson, Jessica (Tester) on 24/02/2019.
//  Copyright © 2019 Pearson, Jessica. All rights reserved.
//

import UIKit
import SwiftyJSON


class StandardGameViewController: UIViewController {

    
    @IBOutlet weak var flagImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - JSON Parsing
    func parseJSON() {
        
        if let path = Bundle.main.path(forResource: "testJson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                //flag array that will store all question objects
                var arrayFlagObjects = [Question]()
            
                for (key, subJson) in jsonObj["flags"] {
                    
                    
                    //create temp variable to store each value of the flag array
                    var countryName = ""
                    var pathName = ""
                    var otherOptions = [String]()
                    
                    //parse json and store in vars above
                    if let title = subJson["countryName"].string {
                        countryName = title
                    }
                    if let imagePathname = subJson["flagUri"].string {
                        pathName = imagePathname
                    }
                    if let options = subJson["altCountries"].arrayObject as? [String] {
                        otherOptions = options
                    }
                    
                    //create Question object passing vars above as arguments
                    var questions = Question(imageURI: pathName, correctAnswer: countryName, otherOptions: otherOptions )
                    
                    //add question object to array of flag objects
                    arrayFlagObjects.append(questions)
                    
                }
                
                print(arrayFlagObjects[1].answer)
                print(arrayFlagObjects[1].flagImage)
                print(arrayFlagObjects[1].options)
                
                
        
            } catch let error {
                print("parse error: \(error.localizedDescription)")
                
            }
        } else {
            print("Invalid filename/path.")
        }
    }
    
    
    
    
    
}
    
    
    
    // MARK - update initital UI
    
    
  
    




 
 


