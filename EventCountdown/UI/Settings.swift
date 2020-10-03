//
//  Settings.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 03/10/2020.
//

import SwiftUI

struct Settings:View {
    @Binding var isOn:Bool
    
    var body: some View{
        VStack(spacing:20){
            Text("Widget Setting")
                .fontWeight(.medium)
                .font(.title)
                .frame(maxWidth: .infinity,alignment:.leading)
                .padding()
            
                Toggle("Cycle Countdows", isOn: $isOn).padding()
                    .labelStyle(DefaultLabelStyle())
            
            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Image(systemName: "phone")
                        .font(.title)
                    Text("Contact Us")
                        .fontWeight(.medium)
                        .font(.title)
                }
                .frame(width:300)
                .padding(.all,10)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
            
            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Image(systemName: "hand.thumbsup")
                        .font(.title)
                    Text("Rate on App Store")
                        .fontWeight(.medium)
                        .font(.title)
                }
                .frame(width:300)
                .padding(.all,10)
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(40)
            }
        }
    }
}

struct Settins_Preview: PreviewProvider {
    
    static var previews: some View{
        Settings(isOn: .constant(true))
    }
}
