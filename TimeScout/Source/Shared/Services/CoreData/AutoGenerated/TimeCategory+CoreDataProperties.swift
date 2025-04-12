//
//  TimeCategory+CoreDataProperties.swift
//  TimeScout
//
//  Created by Matej on 05/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//
//

import Foundation
import CoreData


extension TimeCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeCategory> {
        return NSFetchRequest<TimeCategory>(entityName: "TimeCategory")
    }

    @NSManaged public var name: String
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension TimeCategory {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: TimeActivity)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: TimeActivity)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension TimeCategory : Identifiable {

}
