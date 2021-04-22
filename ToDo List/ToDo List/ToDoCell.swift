//
//  ToDoCell.swift
//  ToDo List
//
//  Created by Anika Nair on 4/13/21.
//

import UIKit

protocol ToDoCellDelegate: class {
    
func checkmarkTapped(sender: ToDoCell)
}

class ToDoCell: UITableViewCell {
    
weak var delegate: ToDoCellDelegate?
    

@IBOutlet var isCompleteButton: UIButton!
@IBOutlet var titleLabel: UILabel!

    
@IBAction func completeButtonTapped (){
        delegate?.checkmarkTapped (sender:self)
    }
    

    
override func awakeFromNib() {
    super.awakeFromNib()
        // Initialization code
    
    }
    
override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
