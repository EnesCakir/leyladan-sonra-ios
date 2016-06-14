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
    @IBOutlet weak var giftButton: LSButton!

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
        self.title = child.name
        textView.text = child.post.htmlToString.string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
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
