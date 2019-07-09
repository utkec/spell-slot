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
    @IBOutlet weak var navTitle: UILabel!
    

    // Create empty spellList qrray
    var spellList = [Spell]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Make enough cells for the number of spell structs in spellList array
        return spellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Show the spell name and level in each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let spell = spellList[indexPath.row]
//        let spellName = cell.viewWithTag(1) as! UILabel
//        let spellSchool = cell.viewWithTag(2) as! UILabel
//        let spellLevel = cell.viewWithTag(3) as! UILabel
        
        cell.textLabel?.text = spellList[indexPath.row].name

        if (spell.level == 0) {
            cell.detailTextLabel?.text = "Cantrip"
        } else {
           cell.detailTextLabel?.text = "\(spell.level)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }
    
    
    
    var rowNum = 0;
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowNum = indexPath.row
        // Segue to the second view controller
        self.performSegue(withIdentifier: "spellInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let secondViewController = segue.destination as! DetailViewController
        
        // set a variable in the second view controller with the data to pass
        secondViewController.sName = spellList[rowNum].name
        secondViewController.sLevel = spellList[rowNum].level
        secondViewController.sSchool = spellList[rowNum].school
        secondViewController.sCastTime = spellList[rowNum].casting_time
        secondViewController.sDuration = spellList[rowNum].duration
        secondViewController.sRange = spellList[rowNum].range
        secondViewController.sComponents = spellList[rowNum].components.raw
        secondViewController.sClass = spellList[rowNum].classes
        secondViewController.sDescription = spellList[rowNum].description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Spells"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Helvetica Bold", size: 25)!]

        let path = Bundle.main.path(forResource: "spells_int", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            self.spellList = try JSONDecoder().decode([Spell].self, from: data)
        } catch {
            // Catch any erros with decoing the JSON file and adding spells to the array
            print("Error decoding JSON file: \(error)")
        }
    
    }
    
}
