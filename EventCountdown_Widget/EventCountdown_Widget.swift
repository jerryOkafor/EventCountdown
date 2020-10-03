//
//  EventCountdown_Widget.swift
//  EventCountdown_Widget
//
//  Created by Jerry Hanks on 02/10/2020.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct EventCountdown_WidgetEntryView : View {
    var entry: Provider.Entry
    let backgound = LinearGradient(gradient: Gradient(colors: [Color.blue, Color.red]), startPoint: .topTrailing, endPoint: .bottomLeading)

    var body: some View {
        Text(entry.date, style: .time)
            .frame(maxWidth:.infinity, maxHeight:.infinity)
            .background(backgound)

    }
}



@main
struct EventCountdown_Widget: Widget {
    let kind: String = "EventCountdown_Widget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EventCountdown_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        
    }
}


struct EventCountdown_Widget_Previews: PreviewProvider {
    static var previews: some View {
        EventCountdown_WidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
