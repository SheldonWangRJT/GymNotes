//
//  GymNotesApp.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 12/27/22.
//

import SwiftUI

@main
struct GymNotesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabsViews(persistenceController: persistenceController)
        }
    }
}
