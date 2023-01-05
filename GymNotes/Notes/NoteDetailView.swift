//
//  NoteDetailView.swift
//  GymNotes
//
//  Created by Xiaodan Wang on 1/4/23.
//

import SwiftUI
import CoreData

struct NoteDetailView: View {
    
    private enum Mode {
        case edit
        case new
    }
    
    // for pop back
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    private let uuid:String?
    private let viewContext: NSManagedObjectContext
    
    private var mode:Mode {
        uuid == nil ? .new : .edit
    }
    
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
            ZStack {
                let item = items.first ?? Item(context: viewContext)
                List {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(itemTimeStampString(item: item))
                    }
                    HStack {
                        Text("Category")
                        Spacer()
                        Text("Tap to select").foregroundColor(.secondary)
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {

                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 50, height: 50)
                                .clipped()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 2)
                                }
                        }
                        .cornerRadius(25)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                    }
                }
            }
        }
        .navigationTitle(navigationTitle())
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
    
    private func itemTimeStampString(item:Item) -> String {
        if let timestamp = item.timestamp {
            return timestamp.formatted()
        }
        let date = Date()
        item.timestamp = date
        return date.formatted()
    }
    
    private func navigationTitle() -> String {
        switch mode {
        case .new:
            return "New Workout"
        case .edit:
            return "Update Workout"
        }
    }
    
    private func saveAndPop() {
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
        NavigationView {
            NoteDetailView(uuid:"uuid1", viewContext: PersistenceController.preview.container.viewContext)
        }
    }
}
