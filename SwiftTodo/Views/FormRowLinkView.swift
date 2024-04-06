//
//  FormRowLinkView.swift
//  SwiftTodo
//
//  Created by Elfana Anamta Chatya on 06/04/24.
//

import SwiftUI

struct FormRowLinkView: View {
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
                
            }
            .frame(width: 36, height: 36, alignment: .center)
            Text(text).foregroundColor(Color.gray)
            Spacer()
            Button(action: {
                guard let url = URL(string: self.link), UIApplication.shared.canOpenURL(url) else {
                return
                }
                UIApplication.shared.open(url as URL)
            }, label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                
            })
            .accentColor(Color(.systemGray2))
        }
        .padding()

    }
}

#Preview(traits: .fixedLayout(width: 375, height: 60)) {
    FormRowLinkView(icon: "globe", color: Color.red, text: "Website", link: "https://github.com/elfaaels")
        .padding()
}
