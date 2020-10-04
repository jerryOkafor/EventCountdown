//
//  EventsViewModel.swift
//  EventCountdown
//
//  Created by Jerry Hanks on 04/10/2020.
//

import Combine
import CoreData

//Ref: https://medium.com/@Dougly/persisting-image-data-locally-swift-3-8bae72673f8a
class EventsViewModel: ObservableObject {

    @Published var events = [EventItem]()
    let fileManager = FileManager.default
    //get url for the users home directory
    lazy var documentsURL: URL = {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }()

    //get the document url as a string
    lazy var documentPath: String = {
        documentsURL.path
    }()

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)

    init() {
        print("\(documentsURL)")
        print("\(documentPath)")
        print("\(photoFilePath(name: "testPhoto"))")

    }


    /// Generate a file path for the given file name
    /// - Parameter name: Name of the file to be generated.
    /// - Returns: URL generated
    func photoFilePath(name: String) -> URL {
        documentsURL.appendingPathComponent("\(String(name)).png")
    }


    /// Save a give file Data
    /// - Parameters:
    ///   - image: Image Data
    ///   - filePath: File path to save the image
    /// - Throws: Error
    func saveFile(image: Data, filePath: URL) throws {
        do {
            try image.write(to: filePath, options: .atomic)
        } catch {
            throw error
        }
    }


    /// Clear all saved files
    /// - Throws: Erorr
    func clearImageCache() throws {
        do {
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")

            for file in files {
                try fileManager.removeItem(atPath: "\(documentPath)\(file)")
            }
        } catch {
            throw error
        }
    }
}
