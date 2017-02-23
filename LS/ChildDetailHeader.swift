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



class ChildDetailHeader: UIView, MXParallaxHeaderProtocol {
  
  @IBOutlet weak var childPhoto: UIImageView!
  
  class func instanciateFromNib() -> ChildDetailHeader {
    return Bundle.main.loadNibNamed("ChildDetailHeader", owner: nil, options: nil)![0] as! ChildDetailHeader
  }
  
  
  func setChild(_ child:Child) {
    //        childName.text = child.name
    childPhoto.af_setImage(
      withURL: URL(string: Constants.URL.Child(child.image.URL))!,
      placeholderImage: UIImage(named: "childNoPhoto"),
      imageTransition: .crossDissolve(0.2),
      completion: { (_) -> Void in })
  }
  
  // MARK: - <MXParallaxHeader>
  
  func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
    //        let angle = parallaxHeader.progress * CGFloat(M_PI) * 2
    //        print(angle)
    //        self.childPhoto.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle/3)
  }
  
}
