//
//  ChildCollectionViewCell.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

class ChildCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var childName: UILabel!
  @IBOutlet weak var facultyName: UILabel!
  @IBOutlet weak var wishLabel: UILabel!
  @IBOutlet weak var childPhoto: UIImageView!
  @IBOutlet weak var detailView:UIView?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
  var isActive = false
  
  // MARK: - Lifecycle
  override func awakeFromNib()
  {
    super.awakeFromNib()
    activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2);
    activityIndicator.startAnimating();
    setInActive()
  }
  
  override func prepareForReuse(){
    super.prepareForReuse()
    setInActive()
  }
  
  func getChildPhoto() -> UIImage {
    return childPhoto.image!
  }
  
  func setActive() {
    UIView.animate(withDuration: 0.5, delay: 0, options:UIViewAnimationOptions.transitionCrossDissolve, animations: {() in
      self.detailView?.alpha = 1.0;}, completion: {(Bool) in
    })
    isActive = true
    Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChildCollectionViewCell.setInActive), userInfo: nil, repeats: false)
  }
  
  func setInActive() {
    isActive = false
    UIView.animate(withDuration: 0.5, delay: 0, options:UIViewAnimationOptions.transitionCrossDissolve, animations: {() in
      self.detailView?.alpha = 0.0;}, completion: {(Bool) in
    })
    
  }
  
  func setChild(_ child:Child) {
    childName.text = child.name
    facultyName.text = child.faculty.name
    wishLabel.text = child.wish
    activityIndicator.startAnimating();
    childPhoto.af_setImage(
      withURL: URL(string: Constants.URL.Child(child.image.URL))!,
      placeholderImage: UIImage(named: "childNoPhoto"),
      imageTransition: .crossDissolve(0.2),
      completion: { (_) -> Void in self.activityIndicator.stopAnimating()})
  }
}
