//
//  SettingsView.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 06/04/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // MARK: - FORM
                Form {
                    // MARK: - SECTION 3
                    Section(header: Text("Others")) {
                        FormRowLinkView(icon: "globe", color: Color.pink, text: "Github", link: "https://github.com/elfaaels")
                    }
                   // MARK: - SECTION 4
                    Section(header: Text("Details")) {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "Todo")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Elfaael")

                    }
                    .padding(.vertical, 3)
                    
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)
                
                // MARK: - FOOTER
                Text("Copyright - All rights reserved.")
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
            }
            .navigationBarItems(trailing:
                Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
              Image(systemName: "xmark")
            })
            )
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    SettingsView()
}
