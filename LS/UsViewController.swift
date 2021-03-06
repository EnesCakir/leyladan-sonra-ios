//
//  UsViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/13/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

class UsViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var textTop: LSTextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var timer = Timer()
    var counter = 0
    var images = ["us1","us2","us6","us3","us4","us5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationItem.title = "Biz Kimiz?"
        setupUI()
        startTimer()
        // Do any additional setup after loading the view.
    }

    @IBAction func showChildren(_ sender: AnyObject) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapImage(_ sender: AnyObject) {
        changeImage()
        resetTimer()
    }
    func setupUI() {
    }

    func changeImage(){
        counter += 1
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            self.imageView.image = UIImage(named: self.images[self.counter % self.images.count])
            }, completion: {_ in})
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(UsViewController.changeImage), userInfo: nil, repeats: true)
    }
    
    func resetTimer(){
        timer.invalidate()
        startTimer()
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
