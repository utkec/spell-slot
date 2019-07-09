//
//  ViewController.swift
//  spell slot
//
//  Created by Casey Utke on 5/25/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var spellTable: UITableView!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var spellSearch: UISearchBar!
    
    var isSearching = false
    
    // Create empty spellList qrray
    var spellList = [Spell]()
    var filteredSpellList = [Spell]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredSpellList.count
        } else {
            return spellList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var spell = spellList[indexPath.row]
        
        if isSearching { // If search then use filtedSpellList
            spell = filteredSpellList[indexPath.row]
        }

        
        
        cell.textLabel?.text = spell.name
        if (spell.level == 0) {
            cell.detailTextLabel?.text = "Cantrip"
        } else {
           cell.detailTextLabel?.text = "\(spell.level)"
        }
        
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            view.endEditing(true)
            spellTable.reloadData()
        } else {
            isSearching = true
            filteredSpellList = spellList.filter {$0.name == spellSearch.text }
            spellTable.reloadData()
        }
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
        // Sort to default view
        spellList = spellList.sorted(by: {$0.level < $1.level})
    }
    
    
    // Sort SpellList by Name
    @IBAction func sortName(_ sender: UIButton) {
        let sortName = spellList.sorted(by: {$0.name < $1.name})
        spellList = sortName
        spellTable.reloadData()
    }
    
    // Sort SpellList be Level
    @IBAction func sortLevel(_ sender: UIButton) {
        let sortLevel = spellList.sorted(by: {$0.level < $1.level})
        spellList = sortLevel
        spellTable.reloadData()
    }
    
}
