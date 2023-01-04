//
//  ContentView.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 12/27/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Workouts")) {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.timestamp ?? Date(), formatter: itemFormatter)")
                            } label: {
                                Text(item.timestamp ?? Date(), formatter: itemFormatter)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }.headerProminence(.increased)
                    Section {
                        Button(action: addItem) {
                            Label("Add Workout", systemImage: "plus")
                        }
                    }.listStyle(.insetGrouped)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Workout", systemImage: "plus")
                        }
                    }
                }
            }
            Text("Create Your Workout!")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                print($0)
                return items[$0]
            }.forEach {
                viewContext.delete($0)
            }

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
