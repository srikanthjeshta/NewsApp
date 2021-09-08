//
//  NewsdataTableViewCell.swift
//  DoYourThngTask
//
//  Created by Work Station 2 on 08/09/21.
//

import UIKit

class NewsdataTableViewCell: UITableViewCell {

    @IBOutlet weak var bgVw: UIView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
