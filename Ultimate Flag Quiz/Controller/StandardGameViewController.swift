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

    var arrayFlagObjects = [Question]()
    var randomiseFlags : Int = 0
    var question = Question()
    
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let answer = sender.titleLabel!.text
        answerPressed(playerAnswer: answer!, correctAnswer: question)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        shuffleArray()
        question = getQuestion(randomiseInt: randomiseFlags)

    

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
                
                //for loop that iterates through json file path provided and creates an array storing this data
                for (_, subJson) in jsonObj["flags"] {
                    
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
                    let questions = Question(imageURI: pathName, correctAnswer: countryName, otherOptions: otherOptions )
                    
                    //add question object to array of flag objects
                    arrayFlagObjects.append(questions)
                    print(arrayFlagObjects.count)
                    
                }
                
            } catch let error {
                
                // MARK - create error screen
                print("parse error: \(error.localizedDescription)")
                
            }
        } else {
            // MARK - create error screen
            print("Invalid filename/path.")
        }
    }
    
    // MARK - shuffle array or does swift already have a method I can use for this?
    //This method will count the completed array and then select a random number from the array which can be used to pick out a random set of flag data
    func shuffleArray() {
        randomiseFlags = Int(arc4random_uniform(UInt32(arrayFlagObjects.count)))
    }
    
    func getQuestion(randomiseInt : Int) -> Question {
        var randomQuestion = Question()
        
        //get question using if e.e if array not empty then {get a random array element and display updat the UI} else end of the game
        if !arrayFlagObjects.isEmpty {
            
            //get random array element & store in local var and remove from overall arrayFlagObjcts array
            randomQuestion = arrayFlagObjects.remove(at: randomiseInt)
            
            
            //update images, question buttons with that arrays data
            updateUI(answerOptions: randomQuestion.options, correctAnswer: randomQuestion.answer, flagImagePath: randomQuestion.flagImage)
            
        }
        return randomQuestion
    }
    
    
    
    // MARK - update initital UI
    // This method will update all the views on screen (flag image, answer options etc)
    func updateUI(answerOptions : Array<String>, correctAnswer : String, flagImagePath : String) {
        
        //take the options for that flag set and store them in 'optionsArray' var
        var optionsArray = answerOptions
        
        //add the correct answer to the array
        optionsArray.append(correctAnswer)
        
        //add value for each option to a var and then remove from the array
        let firstOption = optionsArray.remove(at: Int(arc4random_uniform(4)))
        let secondOption = optionsArray.remove(at: Int(arc4random_uniform(3)))
        let thirdOption = optionsArray.remove(at: Int(arc4random_uniform(2)))
        let fourthOption = optionsArray.remove(at: Int(arc4random_uniform(1)))
        
        //update buttons and flag image
        flagImage.image = UIImage(named: flagImagePath)
        optionOne.setTitle(firstOption, for: .normal)
        optionTwo.setTitle(secondOption, for: .normal)
        optionThree.setTitle(thirdOption, for: .normal)
        optionFour.setTitle(fourthOption, for: .normal)
        
    }
    
    
    // MARK - create answerPressed() method here
    //takes in the title label text for the button the user has pressed as the 'playerAnswer', and also takes in the question object answer vaue.
    // compares them 
    func answerPressed(playerAnswer : String, correctAnswer : Question) {
        let answer = playerAnswer
        let correctAnswer = correctAnswer.answer
        
        if answer == correctAnswer {
            // add code here to change button colour to green if correct
            // also need to add a counter at some point to keep track of score
           print("you got it right")
        } else {
            // add code to change button colour to red if wrong
            // if I want to have 3 lives then this would also need to remove a "life"
            print("Wrong")
        }
    }
}
    
    
    


  
    




 
 


