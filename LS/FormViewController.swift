//
//  FormViewController.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/13/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import FlatUIKit
import SkyFloatingLabelTextField
import FontAwesome_swift
import Alamofire

class FormViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var firstnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var lastnameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var mobileTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    @IBOutlet weak var messageTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var messageTV: UITextView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
    var child = Child()
//    @IBOutlet weak var messageField: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FormViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

//        messageField.layer.borderWidth = 1.0
//        messageField.layer.borderColor = UIColor.blackColor().CGColor
//        messageField.layer.cornerRadius = 4.0;

        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FormViewController.dismissForm))
//        backgroundView.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissForm()
    }
    
    func dismissForm(){
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func setupUI(){
        setupTextFields()
        
        // Rounded view
        self.automaticallyAdjustsScrollViewInsets = false
        scrollView.layer.cornerRadius = 6
        
        //Blur background
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = backgroundView.bounds
        backgroundView.addSubview(blurView)

        //Textfields

    }
    func setupTextFields() {
        coloredTextField(firstnameTF)
        coloredTextField(lastnameTF)
        coloredTextField(emailTF)
        coloredTextField(mobileTF)
        coloredTextField(cityTF)
        coloredTextField(messageTF)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            scrollBottomConstraint.constant = keyboardSize.height
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        scrollBottomConstraint.constant = 20
    }

    func coloredTextField(textField:SkyFloatingLabelTextField) {
                textField.tintColor = UIColor.primaryColor()
                textField.textColor = UIColor.darkGreyColor()
                textField.lineColor = UIColor.lightGreyColor()
                textField.selectedTitleColor = UIColor.primaryColor()
                textField.selectedLineColor = UIColor.primaryColor()
        
                // Set custom fonts for the title, placeholder and textfield labels
                textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
                textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
                textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }

    
// MARK: - UITextView delegate methods
    func textViewDidEndEditing(textView: UITextView)
    {
        messageTF.highlighted = false

        if !textView.hasText() {
            messageTF.setTitleVisible(false, animated: true)
            messageTF.placeholder = "Mesaj"
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        messageTF.setTitleVisible(true, animated: true)
        messageTF.highlighted = true
        messageTF.placeholder = ""
    }
    
    // MARK: - Validating the fields when "submit" is pressed
    
    var isSubmitButtonPressed = false
    
    var showingTitleInProgress = false


    @IBAction func checkValidation(sender: AnyObject) {
        self.isSubmitButtonPressed = true
        if !self.firstnameTF.hasText() {
            showErrorForTextField(firstnameTF)
        }
        if !self.lastnameTF.hasText() {
            showErrorForTextField(lastnameTF)
        }
        if !self.emailTF.hasText() {
            showErrorForTextField(emailTF)
        }
        if !self.mobileTF.hasText() {
            showErrorForTextField(mobileTF)
        }
        if !self.cityTF.hasText() {
            showErrorForTextField(cityTF)
        }
        if !self.messageTV.hasText() {
            showErrorForTextField(messageTF)
        }
    }
    
    @IBAction func send(sender: AnyObject) {
        self.isSubmitButtonPressed = false
        if(!self.showingTitleInProgress) {
            self.hideTitleVisibleFromFields()
            let form = Form(first_name: firstnameTF.text!, last_name: lastnameTF.text!, email: emailTF.text!, mobile: mobileTF.text!, city: cityTF.text!, message: messageTV.text!)
            sendForm(form)
        }
    }

    
    func showingTitleInAnimationComplete() {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: #selector(FormViewController.showingTitleInTitleComplete), userInfo: nil, repeats: false)

    }
    
    func showingTitleInTitleComplete() {
        self.showingTitleInProgress = false
        if(!self.isSubmitButtonPressed) {
            self.hideTitleVisibleFromFields()
        }
    }
    
    func showErrorForTextField(textfield:SkyFloatingLabelTextField) {
        self.showingTitleInProgress = true
        textfield.errorMessage = "Boş bırakılamaz"
        textfield.setTitleVisible(true, animated: true, animationCompletion: self.showingTitleInAnimationComplete)
        textfield.highlighted = true
    }
    
    func hideErrorForTextField(textfield:SkyFloatingLabelTextField) {
        textfield.setTitleVisible(false, animated: true)
        textfield.errorMessage = ""
        textfield.highlighted = false
    }



    func hideTitleVisibleFromFields() {
        hideErrorForTextField(firstnameTF)
        hideErrorForTextField(lastnameTF)
        hideErrorForTextField(emailTF)
        hideErrorForTextField(mobileTF)
        hideErrorForTextField(cityTF)
        hideErrorForTextField(messageTF)
    }


    //MARK: - Textfield delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func sendForm(form:Form){
        let parameters = [
            "id": String(child.id),
            "first_name": form.first_name,
            "last_name": form.last_name,
            "email": form.email,
            "mobile": form.mobile,
            "city": form.city,
            "text": form.message
        ]
        
        Alamofire.request(.POST, Constants.BaseURL + "/child/form", parameters: parameters).response { request, response, data, error in
            if error != nil{
                let alertController = UIAlertController(title: error?.localizedFailureReason, message: error?.localizedDescription , preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            switch response!.statusCode {
            case 404:
                let alertController = UIAlertController(title: "Mesaj Gönderilemedi", message: "Böyle bir çocuk bulunmamaktadır.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default,handler: { (action: UIAlertAction!) in self.dismissForm() }))
                self.presentViewController(alertController, animated: true, completion: nil)
            case 200:
                let alertController = UIAlertController(title: "Tebrikler", message: "Mesajınız başarıyla tarafımıza ulaşmıştır. Vermiş olduğunuz e-posta adresi üzerinden sizinle iletişime geçeceğiz. İyilikle Kalın!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default, handler:{ (action: UIAlertAction!) in self.dismissForm() }))

                self.presentViewController(alertController, animated: true, completion: nil)
            default:
                let alertController = UIAlertController(title: "Mesaj Gönderilemedi", message: "Bilinmeyen bir sebepten dolayı mesajının gönderilemedi. Durumu teknik@leyladansonra.com adresine bildirebilirsiniz.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
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
