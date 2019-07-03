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
    var randomiseFlags = 0
    var question = Question()
    var totalQuestions : Int?
    var checkedAnswer = ""
    var score = 0
    var lives = 3
    
    @IBOutlet weak var playersScore: UITextField!    
    @IBOutlet weak var totalNumberQuestions: UITextField!
    
    @IBOutlet weak var lifeOne: UITextField!
    @IBOutlet weak var lifeTwo: UITextField!
    @IBOutlet weak var lifeThree: UITextField!
    
    @IBOutlet weak var flagImage: UIImageView!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let answer = sender.titleLabel!.text
        
        checkedAnswer = answerPressed(playerAnswer: answer!, correctAnswer: question)
        if checkedAnswer == "Correct" {
            UIView.animate(withDuration: 0.6, animations: {sender.backgroundColor = UIColor.green},
                           completion: { _ in UIView.animate(withDuration: 0.4, animations: {sender.backgroundColor = UIColor.black})
                            })
            playersScore.text = String(score)
            
            //gets next question object and displays it
            shuffleArray()
            question = getQuestion(randomiseInt: randomiseFlags)
        }
        else  {
            UIView.animate(withDuration: 0.6, animations: {sender.backgroundColor = UIColor.red},
                           completion: { _ in UIView.animate(withDuration: 0.6, animations: {sender.backgroundColor = UIColor.black})
                            })
            //call check lives func to see if user has any remaining lives and removes a life if answer is incorrect
            checkLives()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        totalQuestions = arrayFlagObjects.count
        totalNumberQuestions.text = String(totalQuestions!)
        shuffleArray()
        question = getQuestion(randomiseInt: randomiseFlags)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - JSON Parsing
    func parseJSON() {
        
        if let path = Bundle.main.path(forResource: "flag_full", ofType: "json") {
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
    //This method will count the completed array and then select a random number from the array which can be used to pick out a random set of flag data, or if the array is empty then end the game
    func shuffleArray() {
        //if the array isn't empty count how many objects it has and pick a random number between 0 and this number, store it in randomiseFlag var
        if !arrayFlagObjects.isEmpty {
        randomiseFlags = Int(arc4random_uniform(UInt32(arrayFlagObjects.count)))
        }
        //if the array is now empty the player has finished the game, launch the game over VC
        else if arrayFlagObjects.isEmpty {
            performSegue(withIdentifier: "showGameOver", sender: self)
        }
    }
    
    func getQuestion(randomiseInt : Int) -> Question {
        var randomQuestion = Question()
        
        //get question using if e.g if array not empty then {get a random array element and display update the UI} else end of the game
        if !arrayFlagObjects.isEmpty {
            
            //get random array object & store in local question var and remove from overall arrayFlagObjcts array
            randomQuestion = arrayFlagObjects.remove(at: randomiseInt)
            
            
            //update images, question buttons with that arrays data
            //if it's the first question being shown then there will be no delay in the animation
            if arrayFlagObjects.count == totalQuestions!-1 {
                updateUI(answerOptions: randomQuestion.options, correctAnswer: randomQuestion.answer, flagImagePath: randomQuestion.flagImage)
            } else {
                //otherwise apply a 1 second delay when updating the flag and button text
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.updateUI(answerOptions: randomQuestion.options, correctAnswer: randomQuestion.answer, flagImagePath: randomQuestion.flagImage)
                }
            }
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
    
    func checkLives () {
        switch lives {
        case 3:  lifeOne.isHidden = true ;//record incorrect result in var
        case 2: lifeTwo.isHidden = true ; //record incorrect result in var
        case 1: lifeThree.isHidden = true ; //record incorrect result in var
        //when player has no more lives launch game over VC
        case 0: performSegue(withIdentifier: "showGameOver", sender: self)
        default: print("Game Over")
        }
    }
    
    
    // MARK - create answerPressed() method here
    //takes in the title label text for the button the user has pressed as the 'playerAnswer', and also takes in the question object answer value.
    // compares them and returns a string confirming if the answer is correct or incorrect
    func answerPressed(playerAnswer : String, correctAnswer : Question) -> String {
        let answer = playerAnswer
        let correctAnswer = correctAnswer.answer
        var checkedAnswer = ""
        
        if answer == correctAnswer {
            print("you got it right")
            checkedAnswer = "Correct"
            score += 1
        } else {
            print("Wrong")
            checkedAnswer = "Incorrect"
            lives -= 1
        }
        return checkedAnswer
    }
    
    //segue to show game over screen. Passes through the finalScore var to be displayed on the gameOver VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameOver" {
            
            let destinationVC = segue.destination as! GameOverViewController
            destinationVC.finalScore = String(score)
            destinationVC.lives = lives
            destinationVC.totalQuestions = String(totalQuestions!)
        }
    }
    
    
    
}
    
    
    


  
    




 
 


