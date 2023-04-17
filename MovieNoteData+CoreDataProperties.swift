//
//  MovieNoteData+CoreDataProperties.swift
//  movieNote
//
//  Created by 이주상 on 2023/04/17.
//
//

import Foundation
import CoreData


extension MovieNoteData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieNoteData> {
        return NSFetchRequest<MovieNoteData>(entityName: "MovieNoteData")
    }

    @NSManaged public var contents: String?
    @NSManaged public var imageURL: URL?
    @NSManaged public var jpegData: Data?
    @NSManaged public var pubDate: String?
    @NSManaged public var savedDate: Date?
    @NSManaged public var title: String?
    
    var createdAt: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = savedDate else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension MovieNoteData : Identifiable {

}
