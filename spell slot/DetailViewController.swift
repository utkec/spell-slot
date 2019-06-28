//
//  DetailViewController.swift
//  spell slot
//
//  Created by Casey Utke on 6/8/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var spellName: UILabel!
    @IBOutlet weak var spellLevel: UILabel!
    @IBOutlet weak var spellSchool: UILabel!
    @IBOutlet weak var spellCastTime: UILabel!
    @IBOutlet weak var spellDuration: UILabel!
    @IBOutlet weak var spellRange: UILabel!
    @IBOutlet weak var spellComp: UILabel!
    @IBOutlet weak var spellClass: UILabel!
    @IBOutlet weak var spellDesc: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spellName?.text = "test"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
