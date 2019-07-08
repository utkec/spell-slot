//
//  DetailViewController.swift
//  spell slot
//
//  Created by Casey Utke on 6/8/19.
//  Copyright © 2019 Casey Utke. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var spellName: UILabel!
    @IBOutlet weak var spellLevel: UILabel!
    @IBOutlet weak var spellSchool: UILabel!
    @IBOutlet weak var spellCastTime: UILabel!
    @IBOutlet weak var spellDuration: UILabel!
    @IBOutlet weak var spellRange: UILabel!
    @IBOutlet weak var spellComponents: UILabel!
    @IBOutlet weak var spellClass: UILabel!
    @IBOutlet weak var spellDescription: UILabel!
    
    
    var sName: String?
    var sLevel: Int!
    var sSchool: String?
    var sCastTime: String?
    var sDuration: String?
    var sRange: String?
    var sComponents: String?
    var sClass: [String]?
    var sDescription: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = spellName
//        scrollView.contentSize.height = 10000
        
        spellName.text = sName

        if (sLevel == 0) {
            spellLevel.text = "Level: Cantrip"
        } else {
            spellLevel.text = "Level: " + "\(sLevel!)"
        }
        
        spellSchool.text = "School: " + sSchool!.capitalized
        spellCastTime.text = "Cast Time: " + sCastTime!
        spellDuration.text = "Duration: " + sDuration!
        spellRange.text = "Range: " + sRange!
        spellComponents.text = "Components: " + sComponents!
        
        for (index, element) in sClass!.enumerated() {
            sClass![index] = element.capitalized
        }
        spellClass.text = "Class: " + (sClass?.joined(separator: ", "))!
        spellDescription.text = sDescription
    }
    
    override func viewDidLayoutSubviews() {
        spellDescription.sizeToFit()
        spellComponents.sizeToFit()
    }
    
}
