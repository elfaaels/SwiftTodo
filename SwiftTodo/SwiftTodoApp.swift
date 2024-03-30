//
//  SwiftTodoApp.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 30/03/24.
//

import SwiftUI

@main
struct SwiftTodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
