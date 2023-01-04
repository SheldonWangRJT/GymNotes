//
//  NoteDetailView.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 1/4/23.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    // for pop back
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let uuid:String?
    private var viewContext: NSManagedObjectContext

    @FetchRequest private var items: FetchedResults<Item>
    
    init(uuid: String?, viewContext: NSManagedObjectContext) {
        self.uuid = uuid
        self.viewContext = viewContext
        _items = FetchRequest<Item>(
            entity: Item.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
            predicate: NSPredicate(format: "uuid == %@", uuid ?? ""),
            animation: .default)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.uuid ?? "")
                            .foregroundStyle(.primary)
                        Text("\(item.category)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle(uuid != nil ? "Update Workout" : "New Workout")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    saveAndPop()
                } label: {
                    Label("Save Workout", systemImage: "tray.and.arrow.down.fill")
                }
            }
        }
    }
    
    func saveAndPop() {
        withAnimation {
            guard let item = items.first else { return }
            item.updateState = ItemUpdateState.updated.rawValue
            do {
                try viewContext.save()
                self.presentationMode.wrappedValue.dismiss()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                self.presentationMode.wrappedValue.dismiss()
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
        
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView(uuid:nil, viewContext: PersistenceController.shared.container.viewContext)
    }
}
