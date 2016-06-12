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
    @IBOutlet weak var childPhoto: UIImageView!
    @IBOutlet weak var detailView:UIView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var isActive = false
    
    // MARK: - Lifecycle
    override func awakeFromNib()
    {
        super.awakeFromNib()
        activityIndicator.transform = CGAffineTransformMakeScale(2, 2);
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
        UIView.animateWithDuration(0.5, delay: 0, options:UIViewAnimationOptions.TransitionCrossDissolve, animations: {() in
            self.detailView?.alpha = 1.0;}, completion: {(Bool) in
        })
        isActive = true
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ChildCollectionViewCell.setInActive), userInfo: nil, repeats: false)
    }
    
    func setInActive() {
        isActive = false
        UIView.animateWithDuration(0.5, delay: 0, options:UIViewAnimationOptions.TransitionCrossDissolve, animations: {() in
            self.detailView?.alpha = 0.0;}, completion: {(Bool) in
        })

    }

    func setChild(child:Child) {
        childName.text = child.name
        facultyName.text = child.faculty
        activityIndicator.startAnimating();
        childPhoto.af_setImageWithURL(
            NSURL(string: "http://beta.leyladansonra.com/resources/admin/uploads/child_photos/" + child.image.URL)!,
            placeholderImage: UIImage(named: "childNoPhoto"),
            imageTransition: .CrossDissolve(0.2),
            completion: { (_) -> Void in self.activityIndicator.stopAnimating()})
    }
}
