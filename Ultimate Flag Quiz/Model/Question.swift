//
//  Question.swift
//  Ultimate Flag Quiz
//
//  Created by Pearson, Jessica (Tester) on 26/02/2019.
//  Copyright © 2019 Pearson, Jessica. All rights reserved.
//

import Foundation

class Question {
    
    let flagImage : String
    let answer: String
    let options : Array<String>
    
    init(imageURI: String, correctAnswer: String, otherOptions: Array<String>) {
        flagImage = imageURI
        answer = correctAnswer
        options = otherOptions
    }
    
    init() {
        flagImage = ""
        answer = ""
        options = []
    }
}
