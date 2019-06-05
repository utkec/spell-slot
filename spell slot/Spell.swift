//
//  Spell.swift
//  spell slot
//
//  Created by Casey Utke on 6/2/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import Foundation

struct Spell : Decodable { // Creating structure for spell object
    let name:String
    let duration:String
    let casting_time:String
    let classes:[String]
    let description:String
    let range:String
    let ritual:Bool
    let school:String
    let level:Int
    let type:String
    let tags:[String]
    let components:Components
}
