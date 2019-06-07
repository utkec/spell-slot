//
//  ViewController.swift
//  spell slot
//
//  Created by Casey Utke on 5/25/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var spellTable: UITableView!
    
    // Create SpellList Array
//    var spellList = [Spell]()
    var spellList:[Spell] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = spellList[indexPath.row].name
        cell.detailTextLabel?.text = "\(spellList[indexPath.row].level)"
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Import JSON file from url
        let url = "https://raw.githubusercontent.com/utkec/srd_spells/master/spells_int.json"
        
        // Make JSON file into object
        let urlObj = URL(string: url)
        
        // Start URL Session to read JSON file.
        URLSession.shared.dataTask(with: urlObj!) {(data,response,error) in
            
            //Decode JSON file
            do {
                let listOfSpells = try JSONDecoder().decode([Spell].self, from: data!)
                
                for spell in listOfSpells {
                    self.spellList.append(spell)
                }
                
//                for spell in spellList {
//                    print(spell.name)
//                    spell.classes.forEach({ (clazz) in
//                        print(clazz)
//                    })
//                }
                
            } catch {
                print("Error decoding JSON file: \(error)")
            }
        }.resume()
        
        
        // Reload TableView Data
        DispatchQueue.main.async {
            self.spellTable.reloadData()
        }
    }
}
