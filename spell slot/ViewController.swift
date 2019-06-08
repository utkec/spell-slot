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
    
    
    // Create empty spellList qrray
    var spellList = [Spell]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Make enough cells for the number of spell structs in spellList array
        return spellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Show the spell name and level in each cell
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
        
        // Start URL Session to read JSON file, decode it, and add to the array
        URLSession.shared.dataTask(with: urlObj!) {(data,response,error) in
            do {
                // Decode JSON file
                let listOfSpells = try JSONDecoder().decode([Spell].self, from: data!)
                
                // Loops through JSON file and add spells too the spellList array
                for spell in listOfSpells {
                    self.spellList.append(spell)
                }
                
                // Reload TableView Data
                DispatchQueue.main.async {
                    self.spellTable.reloadData()
                }

            } catch {
                // Catch any erros with decoing the JSON file and adding spells to the array
                print("Error decoding JSON file: \(error)")
            }
        }.resume()
    }
}
