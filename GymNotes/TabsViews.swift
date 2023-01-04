//
//  TabsViews.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 1/3/23.
//

import Foundation
import SwiftUI

struct TabsViews: View {
    let persistenceController: PersistenceController
    
    var body: some View {
        TabView {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .tabItem {
                    Label("Workouts", systemImage: "list.bullet.clipboard")
                }

            MyDataView()
                .tabItem {
                    Label("My Data", systemImage: "chart.pie")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "doc.text.image")
                }
        }
    }
}

struct TabsViews_Previews: PreviewProvider {
    static var previews: some View {
        TabsViews(persistenceController: PersistenceController.preview)
    }
}


