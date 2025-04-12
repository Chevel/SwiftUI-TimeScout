//
//  ProTimeRunningActivity+CoreDataProperties.swift
//  TimeScout
//
//  Created by Matej on 14/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import CoreData


extension ProTimeRunningActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProTimeRunningActivity> {
        return NSFetchRequest<ProTimeRunningActivity>(entityName: "ProTimeRunningActivity")
    }

    @NSManaged public var name: String
    @NSManaged public var creationDate: Date
    @NSManaged public var relationship: NSSet?

}

// MARK: Generated accessors for relationship
extension ProTimeRunningActivity {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: ProTimeCategory)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: ProTimeCategory)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension ProTimeRunningActivity : Identifiable {

}
