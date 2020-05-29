//
//  Question.swift
//  RabbleWabble
//
//  Created by Bhavesh Tandel on 02/10/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import Foundation

public class Question: Codable {
    public let answer: String
    public let hint: String?
    public let prompt: String
    public init(answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
    } 
}
