//
//  CustomTVC.swift
//  Api_Task
//
//  Created by Farhana Khan on 11/04/21.
//

import UIKit

class CustomTVC: UITableViewCell {
    
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var headerLb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
