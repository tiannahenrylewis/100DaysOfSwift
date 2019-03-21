//
//  Petition.swift
//  Petitions
//
//  Created by Tianna Henry-Lewis on 2019-03-20.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import Foundation

struct Petition : Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
