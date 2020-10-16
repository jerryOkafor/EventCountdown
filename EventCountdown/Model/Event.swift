//
//  Event.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 15/10/2020.
//

import Foundation
import SwiftUI

struct Event {
    let id: UUID
    let date: Date
    let title: String
    let color: Color
    let widgetPhoto: Image
    
    var url: URL? {
        URL(string: "countDown://\(id.uuidString)")
    }
}


extension EventMO {
    
    func toEvent() -> Event {
        return Event(id: self.id!, date: self.date!, title: self.title!, color: Color.red, widgetPhoto: Image(systemName: "heart"))
    }
}
