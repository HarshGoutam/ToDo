//
//  ToDoApp.swift
//  ToDo
//
//  Created by Harsh Goutam on 07/02/22.
//

import SwiftUI

@main
struct ToDoApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,persistenceController.container.viewContext)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
