//
//  Entity+CoreDataProperties.swift
//  Exam
//
// 
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var day: String?
    @NSManaged public var image: String?
    @NSManaged public var descriptionOne: String?
    @NSManaged public var descriptionTwo: String?

}

extension Entity : Identifiable {

}
