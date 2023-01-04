//
//  DataModels.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 1/4/23.
//

import Foundation

enum ItemUpdateState:Int64 {
    case unknown = 0
    case new = 1
    case updated = 2
}

func itemUpdateStateString(from intVal:Int64) -> String {
    return itemUpdateStateString(state: itemUpdateStateState(from: intVal))
}

func itemUpdateStateString(state: ItemUpdateState) -> String {
    switch state {
    case .unknown:
        return "Unknown"
    case .new:
        return "New!"
    case .updated:
        return "Updated"
    }
}

func itemUpdateStateState(from intVal:Int64) -> ItemUpdateState {
    guard let state = ItemUpdateState(rawValue: intVal) else {
        return ItemUpdateState.unknown
    }
    return state
}
