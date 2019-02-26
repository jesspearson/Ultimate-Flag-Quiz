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
    let multipleChoiceOptions : String
    
    init(image: String, correctAnswer: String, otherOptions: String) {
        flagImage = image
        answer = correctAnswer
        multipleChoiceOptions = otherOptions
    }
}
