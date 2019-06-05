//
//  Components.swift
//  spell slot
//
//  Created by Casey Utke on 6/2/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import Foundation

struct Components : Decodable { // Creating structure for Compenents of the spell object
    let material:Bool
    let materials_needed:[String]?
    let raw: String
    let somatic:Bool
    let verbal:Bool
}
