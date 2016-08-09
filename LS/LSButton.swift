//
//  LSButton.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import FlatUIKit

class LSButton: FUIButton
{
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        
        buttonColor = UIColor.primaryColor()
        shadowColor = UIColor.primaryShadowColor();
        shadowHeight = 3.0;
        cornerRadius = 6.0;
        titleLabel!.font = UIFont.flatFontOfSize(16.0);
        setTitleColor(UIColor.cloudsColor(), forState: .Normal)
        setTitleColor(UIColor.cloudsColor(), forState: .Highlighted)
    }
}