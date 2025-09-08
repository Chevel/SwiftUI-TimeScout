//
//  ProTimeCategory+CoreDataProperties.swift
//  TimeScout
//
//  Created by Matej on 14/05/2023.
//  Copyright © 2022 Matej Kokosinek. All rights reserved.
//

import Foundation
import CoreData


extension ProTimeCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProTimeCategory> {
        return NSFetchRequest<ProTimeCategory>(entityName: "ProTimeCategory")
    }

    @NSManaged public var typeId: Int64
    @NSManaged public var relationship: ProTimeActivity?

}

extension ProTimeCategory : Identifiable {

}
