//
//  ChildDetailHeader.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import MXParallaxHeader
import AlamofireImage

protocol LSDetailHeaderDelegate {
    func photoUrlForHeader() -> NSURL
}


class ChildDetailHeader: UIView, MXParallaxHeaderProtocol {
    
    var delegate: LSDetailHeaderDelegate!
    @IBOutlet weak var childPhoto: UIImageView!
    @IBOutlet weak var childName: UILabel!
    
    class func instanciateFromNib() -> ChildDetailHeader {
        return NSBundle.mainBundle().loadNibNamed("ChildDetailHeader", owner: nil, options: nil)[0] as! ChildDetailHeader
    }
    

    func setChild(child:Child) {
        childName.text = child.name
        childPhoto.af_setImageWithURL(
            NSURL(string: "http://beta.leyladansonra.com/resources/admin/uploads/child_photos/" + child.image.URL)!,
            placeholderImage: UIImage(named: "childNoPhoto"),
            imageTransition: .CrossDissolve(0.2),
            completion: { (_) -> Void in })
    }

    // MARK: - <MXParallaxHeader>
    
    func parallaxHeaderDidScroll(parallaxHeader: MXParallaxHeader) {
//        let angle = parallaxHeader.progress * CGFloat(M_PI) * 2
//        print(angle)
//        self.childPhoto.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle/3)
    }
    
}