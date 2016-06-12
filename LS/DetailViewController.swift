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
    @IBOutlet weak var giftButton: FUIButton!

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
        var alertView = FUIAlertView()
        alertView.title = "Başvuru Formu"
        alertView.message = "Ahmet'in hediyesini almak mı istiyorsun? Formu doldur"
        alertView.addButtonWithTitle("Gönder")
        alertView.addButtonWithTitle("Vazgeç")
        alertView.cancelButtonIndex = 1
        alertView.alertViewStyle = FUIAlertViewStyle.PlainTextInput
        alertView.titleLabel.textColor = UIColor.cloudsColor();
        alertView.titleLabel.font = UIFont.boldFlatFontOfSize(16);
        alertView.messageLabel.textColor = UIColor.cloudsColor();
        alertView.messageLabel.font = UIFont.flatFontOfSize(14);
        alertView.backgroundOverlay.backgroundColor = UIColor.cloudsColor().colorWithAlphaComponent(0.8)
        alertView.alertContainer.backgroundColor = UIColor.midnightBlueColor();
        alertView.defaultButtonColor = UIColor.cloudsColor();
        alertView.defaultButtonShadowColor = UIColor.asbestosColor();
        alertView.defaultButtonFont = UIFont.boldFlatFontOfSize(16);
        alertView.defaultButtonTitleColor = UIColor.asbestosColor();
        
        var textField = FUITextField()
        
        textField.textFieldColor = UIColor.cloudsColor();
        textField.borderColor = UIColor.asbestosColor();
        textField.cornerRadius = 4;
        textField.font = UIFont.flatFontOfSize(14);
        textField.textColor = UIColor.midnightBlueColor();

//        [@[[alertView textFieldAtIndex:0], [alertView textFieldAtIndex:1]] enumerateObjectsUsingBlock:^(FUITextField *textField, NSUInteger idx, BOOL *stop) {
//            [textField setTextFieldColor:[UIColor cloudsColor]];
//            [textField setBorderColor:[UIColor asbestosColor]];
//            [textField setCornerRadius:4];
//            [textField setFont:[UIFont flatFontOfSize:14]];
//            [textField setTextColor:[UIColor midnightBlueColor]];
//            }];
//        [[alertView textFieldAtIndex:0] setPlaceholder:@"Text here!"];

        alertView.show()

    }
    // MARK: - Setups
    func setupUI(){
        self.title = child.name
        textView.text = child.post.htmlToString.string
        
        giftButton.buttonColor = UIColor.turquoiseColor();
        giftButton.shadowColor = UIColor.greenSeaColor();
        giftButton.shadowHeight = 3.0;
        giftButton.cornerRadius = 6.0;
        giftButton.titleLabel!.font = UIFont.flatFontOfSize(16.0);
        giftButton.setTitleColor(UIColor.cloudsColor(), forState: .Normal)
        giftButton.setTitleColor(UIColor.cloudsColor(), forState: .Highlighted)

    }

    func setupHeader(){
        self.automaticallyAdjustsScrollViewInsets = false
        let headerView = NSBundle.mainBundle().loadNibNamed("ChildDetailHeader", owner: self, options: nil).first as? ChildDetailHeader
        headerView?.setChild(child)
        self.scrollView.parallaxHeader.view = headerView
        self.scrollView.parallaxHeader.height = 300
        self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.Fill
        self.scrollView.parallaxHeader.minimumHeight = 0
    }

 
}
