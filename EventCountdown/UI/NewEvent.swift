//
//  NewEvent.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 03/10/2020.
//

import DynamicColor
import Foundation
import SwiftUI


struct CountdoenEvent {
    let date: Data
    let title: String
    let color: Color
    let widgetPhoto: Image
}


struct NewEvent: View {
    @State var title: String = ""
    @State var date = Date()
    @State var selectedColor = Color.green

    var body: some View {
        let oringnalColor = DynamicColor(selectedColor)
        let background = [oringnalColor.lighter(), oringnalColor, oringnalColor.darkened()].map { Color($0) }

        return ZStack {

            LinearGradient(gradient: Gradient(colors: background), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 20) {
                Spacer().frame(height: 20)

                DatePicker("Select Event Date", selection: $date, displayedComponents: .date).datePickerStyle(CompactDatePickerStyle())

                ColorPicker("Select Event Color", selection: $selectedColor).labelStyle(DefaultLabelStyle())

                TextField("Enter event title", text: $title)
                    .font(.largeTitle)
                    .foregroundColor(.white)

                Text("Choose Event Photo here")

//                Spacer().frame(height:20)

                Button(action: {
                    print("Delete tapped!")
                }) {
                    Text("Save Event")
                        .fontWeight(.medium)
                        .font(.title)

                        .frame(width: 300)
                        .padding(.all, 10)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(10)
                }

                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle(self.title.isEmpty ? "New Event" : self.title)

        }
    }
}


struct NewEven_Preview: PreviewProvider {

    static var previews: some View {
        NavigationView {
            NewEvent()
        }
    }
}
