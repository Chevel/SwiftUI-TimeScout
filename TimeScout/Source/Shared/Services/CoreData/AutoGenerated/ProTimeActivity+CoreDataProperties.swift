//
//  ProTimeActivity+CoreDataProperties.swift
//  TimeScout
//
//  Created by Matej on 14/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import CoreData


extension ProTimeActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProTimeActivity> {
        return NSFetchRequest<ProTimeActivity>(entityName: "ProTimeActivity")
    }

    @NSManaged public var name: String
    @NSManaged public var creationDate: Date?
    @NSManaged public var activityID: String
    @NSManaged public var durationSeconds: Double
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension ProTimeActivity {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: ProTimeCategory)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: ProTimeCategory)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension ProTimeActivity : Identifiable {

}
