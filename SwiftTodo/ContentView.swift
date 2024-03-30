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
        @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)])
    
    var todos: FetchedResults<Todo>

    
        @State private var showingAddTodoView: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) { todo in
                    HStack {
                        Text(todo.name ?? "Unknown")
                        Spacer()
                        Text(todo.priority ?? "Unknown")
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
            leading: EditButton(),
            trailing:
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
    
        private func deleteItems(offsets: IndexSet) {
            for index in offsets {
                let todo = todos[index]
                viewContext.delete(todo)
                do {
                    try viewContext.save()
                } catch {
                    print(error)
                }
            }
        }
    
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
