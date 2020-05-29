//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 04/10/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

public class BaseQuestionStrategy: QuestionStrategy {

    public var correctCount: Int {
        get { return questionGroup.score.correctCount }
        set { questionGroup.score.correctCount = newValue }
    }
    public var incorrectCount: Int {
        get { return questionGroup.score.incorrectCount }
        set { questionGroup.score.incorrectCount = newValue }
    }
    private var questionGroupCaretaker: QuestionGroupCaretaker

    private var questionGroup: QuestionGroup {
        return questionGroupCaretaker.selectedQuestionGroup
    }
    private var questionIndex = 0
    private let questions: [Question]
    
    public init(questionGroupCaretaker: QuestionGroupCaretaker,
                questions: [Question]) {
        self.questionGroupCaretaker = questionGroupCaretaker
        self.questions = questions
        self.questionGroupCaretaker.selectedQuestionGroup.score.reset()
    }
    // MARK: - QuestionStrategy
    public var title: String {
        return questionGroup.title
    }
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCaretaker.save()
        guard questionIndex + 1 < questions.count else {
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
        return "\(questionIndex + 1)/\(questions.count)"
    }
}
