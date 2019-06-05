//
//  ViewController.swift
//  spell slot
//
//  Created by Casey Utke on 5/25/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let spellList = [Spell]() // Create SpellList Array
    
    // Table: Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spellList.count
    }
    
    // Table: Data show in cells
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
            do { //Decode JSON file
                let spellList = try JSONDecoder().decode([Spell].self, from: data!)
            } catch { // Catch any stupid errors
                print("Error decoding JSON file")
            }
        }.resume()
       
        //DispatchQueue.main.async {
         //   self.reloadData() // wrong method toou
        //}
    }
}

