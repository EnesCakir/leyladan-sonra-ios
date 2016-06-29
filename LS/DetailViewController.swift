//
//  DetailViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 5/16/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import MXParallaxHeader
import FlatUIKit


class DetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var giftButton: UIButton!
    @IBOutlet weak var facultyLogo: UIImageView!

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var meetingLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    // MARK: - Properties
    var child = Child()

    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupHeader()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func showForm(sender: AnyObject) {
        let formVC = UIStoryboard.formViewController()
        formVC.modalPresentationStyle = .OverCurrentContext
        formVC.child = child
        presentViewController(formVC, animated: true, completion: nil)

        self.navigationController?.pushViewController(UIStoryboard.formViewController(), animated: true)
    }
    
    // MARK: - Setups
    func setupUI(){
        let buttonTitle = NSMutableAttributedString(string: "HEDİYEYİ AL")
        buttonTitle.addAttributes([ NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 20)! ], range: NSMakeRange(0, buttonTitle.length))
        buttonTitle.addAttribute(NSKernAttributeName, value: 5.0, range: NSMakeRange(0, buttonTitle.length))
        buttonTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, buttonTitle.length))
        giftButton.setAttributedTitle(buttonTitle, forState: .Normal)
        giftButton.backgroundColor = UIColor.primaryDarkColor()

        self.title = child.name
        textView.text = child.post.htmlToString.string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        cityLabel.text = child.faculty.city
        meetingLabel.text = NSDate.dateToNSDate(child.meetingDay).toLabel()
        facultyLogo.af_setImageWithURL(
            NSURL(string: Constants.URL.Faculty(child.faculty.image))!,
            placeholderImage: UIImage(named: "ls_logo"),
            imageTransition: .CrossDissolve(0.2))
    }

    func setupHeader(){
        self.automaticallyAdjustsScrollViewInsets = false
        let headerView = NSBundle.mainBundle().loadNibNamed("ChildDetailHeader", owner: self, options: nil).first as? ChildDetailHeader
        headerView?.setChild(child)
        self.scrollView.parallaxHeader.view = headerView
        self.scrollView.parallaxHeader.height = 400
        self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.scrollView.parallaxHeader.minimumHeight = 0
    }

 
}
