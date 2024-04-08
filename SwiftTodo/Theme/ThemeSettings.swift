//
//  ThemeSettings.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 08/04/24.
//

import SwiftUI

// THEME CLASS
class ThemeSettings: ObservableObject {
    @Published var themeSettings: Int = UserDefaults.standard.integer(forKey: "Theme") {
        didSet {
            UserDefaults.standard.set(self.themeSettings, forKey: "Theme")
        }
    }
    private init() {}
     public static let shared = ThemeSettings()
}

