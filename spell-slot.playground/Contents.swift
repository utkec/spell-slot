import UIKit

struct Spell:Decodable { // Creating structure for spell object
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


struct Components:Decodable { // Creating structure for Compenents of the spell object
   let material:Bool
   let materials_needed:[String]?
   let raw:String
   let somatic:Bool
   let verbal:Bool
}
print("Created Spell struct")

// Import JSON file from url
let url = "https://raw.githubusercontent.com/utkec/srd_spells/master/spells_int.json"

// Make JSON file into object
let urlObj = URL(string: url)
print("Created JSON file object")

// Start URL Session to read JSON file.
URLSession.shared.dataTask(with: urlObj!) {(data,response,error) in
    do { //Decode JSON file
        let spellList = try JSONDecoder().decode([Spell].self, from: data!)
        print("Decoded JSON file")
        print("-----------------")
        print("Total # of Spells:", spellList.count)
        
        var i = 1 //Variable for numbering spells in console
        for spell in spellList { //Print spells in
            print(i, spell.name)
            
            // for clazz in spell.classes {
            //    print(clazz)
            // }
            
            // save as above
            spell.classes.forEach({ (clazz) in
                print(clazz)
            })
            
            
            i = i + 1
        }
        print("-----------------")
        
    } catch { // Catch any stupid errors
        print("FUCK! AN ERROR!")
    }
}.resume()
