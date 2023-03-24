//
//  SchoolListCell.swift
//  NYCSchools
//
//  Created by Bhagwan Rajput on 24/03/23.
//

import UIKit

class SchoolListCell: UITableViewCell {
    
    //Outlets and connections
    @IBOutlet var imgWebsite: UIImageView!
    @IBOutlet var lblWebsite: UILabel!
    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var imgEmaik: UIImageView!
    @IBOutlet var lblSchoolName: UILabel!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var VwMainCell: UIView!
    @IBOutlet var imgLocation: UIImageView!
    @IBOutlet var lblSchoolDescription: UILabel!
    @IBOutlet var imgSchool: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
