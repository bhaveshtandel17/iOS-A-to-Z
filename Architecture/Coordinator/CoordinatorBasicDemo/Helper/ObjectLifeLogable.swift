//
//  ObjectLifeLogable.swift
//  CoordinatorBasicDemo
//
//  Created by Bhavesh Tandel on 29/08/19.
//  Copyright © 2019 Bhavesh Tandel. All rights reserved.
//

import UIKit

enum ObjectLifeState: CustomStringConvertible {
    case initialize
    case deinitialize
    var description: String {
        switch self {
        case .initialize: return "Created"
        case .deinitialize: return "Distroyed"
        }
    }
}

protocol ObjectLifeLogable { }

extension ObjectLifeLogable where Self: AnyObject {
    func printObejectLifeEventChanges(state: ObjectLifeState) {
        let nameOfObejct = String(describing: Self.self)
        print("ObjectLife: \(nameOfObejct) | \(state.description)")
    }
}
