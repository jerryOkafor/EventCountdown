//
//  EventItem.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 03/10/2020.
//

import SwiftUI

struct EventItem:View {
    @Binding var selectedColor:Color
    
    var body: some View{
        GeometryReader{geo in
            VStack(spacing:10){
                HStack{
                    Text("Birthday")
                        .fontWeight(.bold)
                        .font(.largeTitle)
                        .frame(maxHeight:.infinity , alignment: .top)
                    
                    Spacer(minLength: 20)
                    Image(systemName:"chevron.right").resizable().frame(width: 10, height: 20)
                }.frame(maxWidth:geo.size.width,maxHeight:80, alignment: .leading)
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 10.0,style: .continuous).stroke(Color.blue))
                
                HStack(spacing:20){
                    ScrollView(.horizontal){
                        HStack(alignment:.center, spacing:20){
                            ColorDot()
                            ColorDot()
                            ColorDot()
                            ColorDot()
                            ColorDot()
                        }
                    }
                    ColorPicker("", selection: $selectedColor).labelsHidden()
                }
                
                .frame(maxWidth:.infinity, maxHeight: 35,alignment: .leading)
                
            }.padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .frame(width: geo.size.width,alignment:.top)
        }
    }
}

struct ColorDot:View {
    var body: some View{
        Button(action: {}, label: {
            VStack(spacing:5){
                Text("")
                    .frame(width: 30, height: 20)
                    .background(RoundedRectangle(cornerRadius: 15.0).fill(Color.green))
                Text("")
                    .frame(width: 8, height: 8)
                    .background(RoundedRectangle(cornerRadius: 4.0).fill(Color.white))
            }
        })
    }
}


struct EventItem_Preview : PreviewProvider {
    
    
    
    static var previews: some View{
        EventItem(selectedColor: .constant(Color.red))
    }
}


struct ColorDot_Preview:PreviewProvider {
    static var previews: some View{
        ColorDot()
    }
}
