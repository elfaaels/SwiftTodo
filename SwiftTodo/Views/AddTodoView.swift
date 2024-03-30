//
//  AddTodoView.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 30/03/24.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let priorities = ["High", "Normal", "Low"]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // MARK: - SAVE BUTTON
                    Button(action: {
                        let todo = Todo(context: self.viewContext)
                        todo.name = self.name
                        todo.priority = self.priority
                        
                        do {
                            try self.viewContext.save()
                        } catch {
                            print(error)
                        }
                    }, label: {
                        Text("Save")
                    })
                }
                Spacer()
            }
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
            })
            )
        }
    }
}

#Preview {
    AddTodoView()
}
