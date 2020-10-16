//
//  NewEvent.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 03/10/2020.
//

import CoreData
import DynamicColor
import Foundation
import SwiftUI
import Resolver

struct NewEvent: View {
    @State var title: String = ""
    @State var date = Date()
    @State var selectedColor = Color.green
    
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @Injected
    var viewModel: NewEventViewModel
    
    var body: some View {
        let originalColor = DynamicColor(selectedColor)
        let background = [originalColor.lighter(), originalColor,
                          originalColor.darkened(), originalColor.shaded()]
            .map { Color($0) }
        
        //generate constrasting colors for the inputs
        let fColor = originalColor.inverted()
        
        return ZStack {
            
            LinearGradient(gradient: Gradient(colors: background), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 20) {
                Spacer().frame(height: 20)
                
                DatePicker("Select Event Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                
                ColorPicker("Select Event Color", selection: $selectedColor).labelStyle(DefaultLabelStyle())
                
                TextField("Enter event title", text: $title)
                    .font(.largeTitle)
                    .foregroundColor(Color(hex: UInt64(fColor.toHex())))
                
                //                Text("Choose Event Photo here")
                
                Spacer().frame(height: 20)
                
                Button(action: {
                    viewModel.sayHello()
                }, label: {
                    Text("Save Event")
                        .font(.title3)
                        .frame(width: 300)
                        .padding(.all, 10)
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing))
                        .cornerRadius(15)
                })
                
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
            //            NewEvent(viewModel: .constant())
            Text("I am here")
        }
    }
}
