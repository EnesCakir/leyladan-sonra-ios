//
//  LSTextView.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 7/28/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

class LSTextView: UITextView {
        required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
            let paragraphStyle = NSMutableParagraphStyle();
            paragraphStyle.firstLineHeadIndent = 20.0
            let font = UIFont.systemFontOfSize(16)
            
            var attributed = NSMutableAttributedString(string: self.text, attributes: [NSParagraphStyleAttributeName:paragraphStyle])
            attributed.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0,length:attributed.length))
            self.attributedText = attributed
            self.textAlignment = NSTextAlignment.Justified
        }
    

}
