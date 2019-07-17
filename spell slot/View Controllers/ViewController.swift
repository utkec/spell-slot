//
//  ViewController.swift
//  spell slot
//
//  Created by Casey Utke on 5/25/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var spellTable: UITableView!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var spellSearch: UISearchBar!
    
    var isSearching = false
    
    // Create empty spellList qrray
    var spellList = [Spell]()
    var filteredSpellList = [Spell]()
    
    
    
    
    // Create the size of the table. If searching, use filteed array. Otherwise use regular array.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredSpellList.count
        } else {
            return spellList.count
        }
    }
    
    
    
    // Create each table cell for each spell in one of the spell arrays
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create table cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Create variable for the array to use for the cells (default is regular array)
        var spell = spellList[indexPath.row]
        
        // Switch to Filtered Array if using the search bar
        if isSearching {
            spell = filteredSpellList[indexPath.row]
        }

        // Display spell name and level on table cell
        cell.textLabel?.text = spell.name
        if (spell.level == 0) {
            cell.detailTextLabel?.text = "Cantrip"
        } else {
           cell.detailTextLabel?.text = "\(spell.level)"
        }
        
        return cell
    }
    
    
    // Search bar search function
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // If not searching, end editing, and reload table back to previous state.
        // Otherwise, make the filtered array equal to whatever is filtered in the regular array
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            spellTable.reloadData()
        } else {
            isSearching = true
            guard let text = spellSearch.text else {
                assertionFailure("No search queary was entered")
                return
            }
            filteredSpellList = spellList.filter {$0.name.contains(text)}
            spellTable.reloadData()
        }
    }
    

    
    // Height for each cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;
    }
    
    
    // Declare variable for the row number.
    var rowNum = 0;
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowNum = indexPath.row
        // Segue to the second view controller
        self.performSegue(withIdentifier: "spellInfo", sender: self)
    }
    
    // Runs before seque, changes what data will be scene in DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // get a reference to the second view controller
        let secondViewController = segue.destination as! DetailViewController
        var spell = spellList[rowNum]
        if isSearching {
            spell = filteredSpellList[rowNum]
        }
        
        // set a variable in the second view controller with the data to pass
        secondViewController.sName = spell.name
        secondViewController.sLevel = spell.level
        secondViewController.sSchool = spell.school
        secondViewController.sCastTime = spell.casting_time
        secondViewController.sDuration = spell.duration
        secondViewController.sRange = spell.range
        secondViewController.sComponents = spell.components.raw
        secondViewController.sClass = spell.classes
        secondViewController.sDescription = spell.description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spellSearch.delegate = self
        spellSearch.returnKeyType = UIReturnKeyType.done
        
        // Sets title of ViewController
        self.title = "Spells"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "Helvetica Bold", size: 25)!]

        // Get JSON file from project
        let path = Bundle.main.path(forResource: "spells_int", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        
        // Loop through JSON file and add it to the spellList Array.
        do {
            let data = try Data(contentsOf: url)
            self.spellList = try JSONDecoder().decode([Spell].self, from: data)
        } catch {
            // Catch any errors with decoding the JSON file and adding spells to the array
            print("Error decoding JSON file: \(error)")
        }
        // Default sorted view
        spellList = spellList.sorted(by: {$0.level < $1.level})
        
    }
    
    
    // Sort SpellList by Name
    @IBAction func sortName(_ sender: UIButton) {
        if isSearching {
            let filteredSortName = filteredSpellList.sorted(by: {$0.name < $1.name})
            filteredSpellList = filteredSortName
            spellTable.reloadData()
        } else {
            let sortName = spellList.sorted(by: {$0.name < $1.name})
            spellList = sortName
            spellTable.reloadData()
        }
    }
    
    // Sort SpellList be Level
    @IBAction func sortLevel(_ sender: UIButton) {
        if isSearching {
            let filteredSortLevel = filteredSpellList.sorted(by: {$0.level < $1.level})
            filteredSpellList = filteredSortLevel
            spellTable.reloadData()
        } else {
            let sortLevel = spellList.sorted(by: {$0.level < $1.level})
            spellList = sortLevel
            spellTable.reloadData()
        }
    }
    
}
