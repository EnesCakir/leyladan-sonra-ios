//
//  LeylaViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/13/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import MXParallaxHeader

class LeylaViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeader()
        self.navigationItem.title = "Leyla Kimdir?"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setupHeader(){
        self.automaticallyAdjustsScrollViewInsets = false
        let headerView = NSBundle.mainBundle().loadNibNamed("LeylaHeader", owner: self, options: nil).first as? LeylaHeader
        self.scrollView.parallaxHeader.view = headerView
        self.scrollView.parallaxHeader.height = 400
        self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.scrollView.parallaxHeader.minimumHeight = 0
    }

    @IBAction func showChildren(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
