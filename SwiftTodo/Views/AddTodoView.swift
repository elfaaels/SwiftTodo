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
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24,weight: .bold
                                      , design: .default))
                    
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
//                                print("New Todo: \(todo.name ?? ""), Priority:\(todo.priority ?? "")")
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
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(9)
                            .foregroundColor(Color.white)
                    })
                } //: VSTACK
                .padding(.horizontal)
                .padding(.vertical, 30)
                
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
