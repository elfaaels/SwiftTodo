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
        @State private var animatingButton: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
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
                if todos.count == 0 {
                   EmptyListView()
                }
                
            } //: ZSTACK
            .sheet(isPresented: $showingAddTodoView, content: {
                AddTodoView().environment(\.managedObjectContext, self.viewContext)
            })
            // MARK: - FAB
            .overlay(
                ZStack {
                    Group {
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.2 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 68, height: 68, alignment: .center)
                        Circle()
                            .fill(Color.blue)
                            .opacity(self.animatingButton ? 0.15 : 0)
                            .scaleEffect(self.animatingButton ? 1 : 0)
                            .frame(width: 88, height: 88, alignment: .center)
                     
                    }
                    .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    Button(action: {
                        self.showingAddTodoView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(Circle().fill(Color("ColorBase")))
                            .frame(width: 48, height: 48, alignment: .center)
                }
                    .onAppear(
                        perform: {
                            self.animatingButton.toggle()
                        }
                    )
                }
                    .padding(.bottom, 15)
                    .padding(.trailing, 15)
                , alignment: .bottomTrailing
            )
           
        }
     
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
    
   
    
}
#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)

}

//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

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
