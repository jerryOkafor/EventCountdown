//
//  ContentView.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 02/10/2020.
//

import CoreData
import DynamicColor
import PartialSheet
import SwiftUI

struct ContentView: View {
    @State var isEditMode: Bool = false
    @State var settingsActive: Bool = false
    @State var datePickerActive: Bool = true
    @State var colorPickerActive: Bool = false
    @State var isNewEvent: Bool = false

    @State private var selectedDate = Date()
    @State var currentDate: String = "Oct 17th, 2020"
    @State private var selectedColor = Color(.sRGB, red: 0.98, green: 0.9, blue: 0.2)

    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var sheetManager: PartialSheetManager

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)


    private var items: FetchedResults<Item>


    var body: some View {
        let oringnalColor = DynamicColor(selectedColor)
        let background = [oringnalColor.lighter(), oringnalColor, oringnalColor.darkened()].map { Color($0) }

       return NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: background), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)

                NavigationLink(
                    destination: NewEvent(selectedColor: selectedColor),
                    isActive: $isNewEvent,
                    label: {})
                VStack(alignment: .leading, spacing: 10, content: {
                    //Event Data
                    eventDate(isInEditMode: isEditMode, currentDate: currentDate)

                    //Countdown
                    VStack(alignment: .leading) {
                        HStack {
                            Text("13")
                                .font(.system(size: 120, weight: .bold, design: .default))
                        }
                        Text("days until").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                    EventItem(selectedColor: $selectedColor)

                    Spacer()

                    if !isEditMode {
                        homeButtons()
                    } else {
                        editButtons()
                    }
                })

                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(.horizontal, 20).padding(.top, 10)
                .navigationTitle("Countdown")
            }
            .addPartialSheet()
       }


//        NavigationView{
//            ZStack{
//                VStack(alignment:.leading, spacing:10){


                    //courosel
    //                HStack{
    //                    ColorPicker("", selection: $bgColor).labelsHidden()
    //                }

                    //control

    //                DatePicker(selection: $selectedDate,displayedComponents: .date) {
    //                    Text("Event Date")
    //                        .textCase(.uppercase)
    //                        .font(.subheadline)
    //                        .frame(alignment: .leading)
    //                }.datePickerStyle(GraphicalDatePickerStyle())


//                }.padding()
//                .navigationTitle("Event Countdown")
//

    //            .background(Color.blue)
    //            List {
    //                ForEach(items) { item in
    //                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
    //                }
    //                .onDelete(perform: deleteItems)
    //            }
    //            .toolbar {
    //                HStack{
    //                    #if os(iOS)
    //                    EditButton()
    //                    #endif
    //
    //                    Button(action: addItem) {
    //                        Label("Add Item", systemImage: "plus")
    //                    }
    //                }
    //            }
//            }.ignoresSafeArea()
//            .background(backgound)
//
//        }


    }

    private func eventDate(isInEditMode: Bool, currentDate: String) -> some View {
        Button(action: {
            self.sheetManager.showPartialSheet {
                Section {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date) .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()

                }.padding(.vertical, 10)

            }
        }, label: {
            HStack(alignment: .center, content: {
                VStack(alignment: .leading) {
                    Text("Event Date")
                        .textCase(.uppercase)
                        .font(.subheadline)
                        .frame(alignment: .leading)
                    Text(currentDate)
                        .font(.title3)

                }
                Spacer(minLength: 20)
                Image(systemName: "chevron.right").resizable().frame(width: 10, height: 20)

            })
        })
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .frame(width: 240, alignment: .leading)
        .background(RoundedRectangle(cornerRadius: 10.0, style: .continuous).stroke(Color.blue))

    }

    private func homeButtons() -> some View {
        HStack(alignment: .center) {
            button(action: editItem, title: "Edit", icon: "square.and.pencil")
            Spacer()
            button(action: addItem, title: "Add", icon: "plus")
            Spacer()
            button(action: settings, title: "Settings", icon: "gear")
        }
    }

    private func editButtons() -> some View {
        HStack(alignment: .center) {
            button(action: deleteItem, title: "Delete", icon: "trash")
            Spacer()
            button(action: saveItem, title: "Save", icon: "checkmark")
        }
    }

    private func button(action: @escaping () -> Void, title: String, icon: String)-> some View {
        Button(action: action, label: {

            VStack(alignment: .center, spacing: 10) {
                Image(systemName: icon).font(.largeTitle).foregroundColor(.white)
                Text(title).font(.caption).foregroundColor(.white)
            }.padding()
        }).frame(width: 100, height: 80, alignment: .center)
    }

    private func settings() {
        self.sheetManager.showPartialSheet { Settings(isOn: $settingsActive) }
    }

    private func deleteItem() {

    }

    private func saveItem() {
        print("Saving Item")
        withAnimation {
            self.isEditMode = false
        }

    }

    private func editItem() {
        print("Editing")
        withAnimation {
            self.isEditMode = true
        }

    }

    private func addItem() {
        self.isNewEvent = true

//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
