//
//  CustomTVC.swift
//  DemoProject
//
//  Created by Tarun Prajapati on 21/02/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import UIKit

class CustomTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var label: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
    }

}
