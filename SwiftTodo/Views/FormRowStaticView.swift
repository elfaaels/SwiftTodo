//
//  FormRowStaticView.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 06/04/24.
//

import SwiftUI

struct FormRowStaticView: View {
    var icon: String
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36)
            Text(firstText)
                .foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
            
        }
        .padding()
    }
}

#Preview(traits: .fixedLayout(width: 375, height: 60)) {
    FormRowStaticView(icon: "gear", firstText: "Settings", secondText: "Application")
}
