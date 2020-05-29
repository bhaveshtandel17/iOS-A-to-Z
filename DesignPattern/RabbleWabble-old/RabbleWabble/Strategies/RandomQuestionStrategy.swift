//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 03/10/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation
import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: BaseQuestionStrategy {
    public convenience init(
        questionGroupCaretaker: QuestionGroupCaretaker) {
        let questionGroup =
            questionGroupCaretaker.selectedQuestionGroup!
        let randomSource = GKRandomSource.sharedRandom()
        let questions = randomSource.arrayByShufflingObjects(
            in: questionGroup.questions) as! [Question]
        self.init(questionGroupCaretaker: questionGroupCaretaker,
                  questions: questions)
    }
}
