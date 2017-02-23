//
//  ChildDetailHeader.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import MXParallaxHeader



class LeylaHeader: UIView, MXParallaxHeaderProtocol {
        
    class func instanciateFromNib() -> LeylaHeader {
        return Bundle.main.loadNibNamed("LeylaHeader", owner: nil, options: nil)![0] as! LeylaHeader
    }
    
    
    // MARK: - <MXParallaxHeader>
    
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        //        let angle = parallaxHeader.progress * CGFloat(M_PI) * 2
        //        print(angle)
        //        self.childPhoto.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle/3)
    }
    
}
