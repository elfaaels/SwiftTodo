//
//  ContentView.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 30/03/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
        @Environment(\.managedObjectContext) private var viewContext
//        private var todos: FetchedResults<Todo>

    
//        @FetchRequest(
//            sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//            animation: .default)
    
    @State private var showingAddTodoView: Bool = false
    
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hi")
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
            Button(action: {
                self.showingAddTodoView.toggle()
            },
                       label: {
                Image(systemName: "plus")
                    
            })
                .sheet(isPresented: $showingAddTodoView, content: {
                    AddTodoView().environment(\.managedObjectContext, self.viewContext)
                })
            )
        }
        
        
        //        NavigationView {
        //            List {
        //                ForEach(items) { item in
        //                    NavigationLink {
        //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
        //                    } label: {
        //                        Text(item.timestamp!, formatter: itemFormatter)
        //                    }
        //                }
        //                .onDelete(perform: deleteItems)
        //            }
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarTrailing) {
        //                    EditButton()
        //                }
        //                ToolbarItem {
        //                    Button(action: addItem) {
        //                        Label("Add Item", systemImage: "plus")
        //                    }
        //                }
        //            }
        //            Text("Select an item")
        //        }
    }
    
    //    private func addItem() {
    //        withAnimation {
    //            let newItem = Item(context: viewContext)
    //            newItem.timestamp = Date()
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    //
    //    private func deleteItems(offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { items[$0] }.forEach(viewContext.delete)
    //
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Replace this implementation with code to handle the error appropriately.
    //                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    //                let nsError = error as NSError
    //                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //            }
    //        }
    //    }
    //}
    //
    //private let itemFormatter: DateFormatter = {
    //    let formatter = DateFormatter()
    //    formatter.dateStyle = .short
    //    formatter.timeStyle = .medium
    //    return formatter
    //}()
    
}
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}
