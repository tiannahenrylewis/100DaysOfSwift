//
//  Person.swift
//  NameToFaces
//
//  Created by Tianna Henry-Lewis on 2019-05-07.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String

    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
