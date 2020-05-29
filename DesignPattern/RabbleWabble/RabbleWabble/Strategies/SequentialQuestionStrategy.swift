//
//  SequentialQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 29/05/20.
//  Copyright © 2020 Bhavesh Tandel. All rights reserved.
//

import Foundation
public class SequentialQuestionStrategy: QuestionStrategy {
    // MARK: - Properties
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    // MARK: - Object Lifecycle
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
    }
    // MARK: - QuestionStrategy
    public var title: String {
        return questionGroup.title
    }
    public func currentQuestion() -> Question {
        return questionGroup.questions[questionIndex]
    }
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 <
            questionGroup.questions.count else {
                return false
        }
        questionIndex += 1
        return true
    }
    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/" +
        "\(questionGroup.questions.count)"
    }
}
