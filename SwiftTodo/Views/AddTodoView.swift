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
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
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
                        if self.name != "" {
                            let todo = Todo(context: self.viewContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do {
                                try self.viewContext.save()
                                print("New Todo: \(todo.name ?? ""), Priority:\(todo.priority ?? "")")
                            } catch {
                                print(error)
                            }
                        } else {
                            // ERROR
                            self.errorShowing = true
                            self.errorTitle = "Invalid"
                            self.errorMessage = "Type Something..."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                      
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
        .alert(isPresented: $errorShowing, content: {
            Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        })
    }
}

#Preview {
    AddTodoView()
}
