//
//  TimeActivity+CoreDataProperties.swift
//  TimeScout
//
//  Created by Matej on 08/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import CoreData


extension TimeActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimeActivity> {
        return NSFetchRequest<TimeActivity>(entityName: "TimeActivity")
    }

    @NSManaged public var timestamp: Date?
    @NSManaged public var activityID: String
    @NSManaged public var relationship: TimeCategory?

}

extension TimeActivity : Identifiable {

}
