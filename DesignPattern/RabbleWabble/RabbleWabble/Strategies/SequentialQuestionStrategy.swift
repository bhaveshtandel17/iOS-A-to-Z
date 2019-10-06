//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 03/10/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

public class SequentialQuestionStrategy: BaseQuestionStrategy {
        public convenience init(
            questionGroupCaretaker: QuestionGroupCaretaker) {
            let questionGroup =
                questionGroupCaretaker.selectedQuestionGroup!
            let questions = questionGroup.questions
            self.init(questionGroupCaretaker: questionGroupCaretaker,
                      questions: questions)
        }
}
