//
//  ButtomButton.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 11/10/2020.
//

import SwiftUI

struct BottomButton: View {
    let title: String
    let icon: String
    let action : () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: icon)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.white)
                
            }.padding()
        }.frame(width: 100, height: 80, alignment: .center)
    }
}


struct BottomButton_Preview: PreviewProvider {
    
    static var previews: some View {
        BottomButton(title: "Buttom", icon: "trash") {}
            .background(Color.green)
    }
}
