//
//  MenuCell.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/13/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

protocol LSContextMenuCellDelegate {
    func closeMenu()
}

class MenuCell: UITableViewCell, YALContextMenuCell {

    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuTitleLabel: UILabel!
    
    var delegate: LSContextMenuCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None;
        self.layer.masksToBounds = true;
        self.layer.shadowOffset = CGSizeMake(0, 2);
        self.layer.shadowColor = UIColor(red: 181.0/255.0, green: 181.0/255.0, blue: 181.0/255.0, alpha: 1).CGColor
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    // MARK: - IBActions
    @IBAction func closeMenu(sender: AnyObject) {
        delegate.closeMenu()
    }

    
    //MARK: YALContextMenuCell
    func animatedIcon() -> UIView! {
        return menuImageView
    }
    
    func animatedContent() -> UIView! {
        return menuTitleLabel
    }
    
}
