//
//  Components.swift
//  spell slot
//
//  Created by Casey Utke on 6/2/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import Foundation

// Creating structure for Compenents of the spell object
struct Components : Decodable {
    let material:Bool
    let materials_needed:[String]?
    let raw: String
    let somatic:Bool
    let verbal:Bool
}
