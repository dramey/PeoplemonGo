//
//  CaughtTableViewCell.swift
//  PeoplemonGo
//
//  Created by Deb Ramey on 11/10/16.
//  Copyright © 2016 Deb Ramey. All rights reserved.
//

import UIKit

class CaughtTableViewCell: UITableViewCell {

    @IBOutlet weak var caughtLabel: UILabel!
    
    var person: Person!
    
    func setUpCell(person: Person){
        self.person = person
        caughtLabel.text = person.userName
    }
 

}
