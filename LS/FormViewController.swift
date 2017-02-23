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
import Alamofire

class FormViewController: BaseViewController, UITextViewDelegate, UITextFieldDelegate {
  
  // MARK: Properties
  var child = Child()
  
  // MARK: IBOutlets
  @IBOutlet weak var firstnameTF: SkyFloatingLabelTextField!
  @IBOutlet weak var lastnameTF: SkyFloatingLabelTextField!
  @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
  @IBOutlet weak var mobileTF: SkyFloatingLabelTextField!
  @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
  @IBOutlet weak var messageTF: SkyFloatingLabelTextField!
  @IBOutlet weak var messageTV: UITextView!
  //    @IBOutlet weak var cancelButton: LSButton!
  
  @IBOutlet weak var descriptionLabel: UILabel!
  //    @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var scrollBottomConstraint: NSLayoutConstraint!
  
  // MARK: Life cycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupForm()
    self.title = "Hediye Başvuru Formu"
    // Do any additional setup after loading the view.
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    dismissKeyboard()
  }
  
  func dismissForm(){
    self.navigationController?.popViewController(animated: true)
  }
  
  // MARK: Setups
  func setupUI(){
    setupTextFields()
    descriptionLabel.text = "\(child.name) için hediye almak mı istiyorsunuz? Formu doldurunuz"
    // Rounded view
    self.automaticallyAdjustsScrollViewInsets = false
    
    //        scrollView.layer.cornerRadius = 6
    
    //Blur background
    //        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Light)
    //        let blurView = UIVisualEffectView(effect: darkBlur)
    //        blurView.frame = self.view.bounds
    //        backgroundView.addSubview(blurView)
    
    //Cancel button
    //        cancelButton.buttonColor = UIColor.alizarinColor()
    //        cancelButton.shadowColor = UIColor.pomegranateColor()
    
  }
  
  func setupTextFields() {
    firstnameTF.paintPrimary()
    lastnameTF.paintPrimary()
    emailTF.paintPrimary()
    mobileTF.paintPrimary()
    cityTF.paintPrimary()
    messageTF.paintPrimary()
  }
  
  func setupForm(){
    if let v = Constants.UserDefaults.object(forKey: "volunteer"){
      if let volunteer = v as? NSDictionary {
        firstnameTF.text = volunteer["first_name"] as? String
        lastnameTF.text = volunteer["last_name"] as? String
        emailTF.text = volunteer["email"] as? String
        mobileTF.text = volunteer["mobile"] as? String
        cityTF.text = volunteer["city"] as? String
      }
    }
  }
  
  // MARK: IBAactions
  @IBAction func checkValidation(_ sender: AnyObject) {
    self.isSubmitButtonPressed = true
    if !self.firstnameTF.hasText {
      self.showingTitleInProgress = true
      firstnameTF.showError(animationCompletion: self.showingTitleInAnimationComplete() )
    }
    if !self.lastnameTF.hasText {
      self.showingTitleInProgress = true
      lastnameTF.showError(animationCompletion: self.showingTitleInAnimationComplete())
    }
    if !self.emailTF.hasText {
      self.showingTitleInProgress = true
      emailTF.showError(animationCompletion: self.showingTitleInAnimationComplete())
    }
    if !self.mobileTF.hasText {
      self.showingTitleInProgress = true
      mobileTF.showError(animationCompletion: self.showingTitleInAnimationComplete())
    }
    if !self.cityTF.hasText {
      self.showingTitleInProgress = true
      cityTF.showError(animationCompletion: self.showingTitleInAnimationComplete())
    }
    if !self.messageTV.hasText {
      self.showingTitleInProgress = true
      messageTF.showError(animationCompletion: self.showingTitleInAnimationComplete())
    }
  }
  
  @IBAction func send(_ sender: AnyObject) {
    self.isSubmitButtonPressed = false
    if(!self.showingTitleInProgress) {
      self.hideTitleVisibleFromFields()
      let form = Form(first_name: firstnameTF.text!, last_name: lastnameTF.text!, email: emailTF.text!, mobile: mobileTF.text!, city: cityTF.text!, message: messageTV.text!)
      sendForm(form)
    }
  }
  
  override func keyboardWillShow(_ notification: Notification) {
    super.keyboardWillShow(notification)
    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
      self.scrollBottomConstraint.constant = keyboardSize.height
    }
  }
  
  override func keyboardWillHide(_ notification: Notification) {
    super.keyboardWillHide(notification)
    scrollBottomConstraint.constant = 0
  }
  
  // MARK: - UITextView delegate methods
  func textViewDidEndEditing(_ textView: UITextView){
    messageTF.isHighlighted = false
    if !textView.hasText {
      messageTF.setTitleVisible(false, animated: true)
      messageTF.placeholder = "Mesaj"
    }
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    messageTF.setTitleVisible(true, animated: true)
    messageTF.isHighlighted = true
    messageTF.placeholder = ""
  }
  
  // MARK: Validations
  
  var isSubmitButtonPressed = false
  var showingTitleInProgress = false
  
  
  func showingTitleInAnimationComplete() {
    Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(FormViewController.showingTitleInTitleComplete), userInfo: nil, repeats: false)
  }
  
  func showingTitleInTitleComplete() {
    self.showingTitleInProgress = false
    if(!self.isSubmitButtonPressed) {
      self.hideTitleVisibleFromFields()
    }
  }
  
  
  func hideTitleVisibleFromFields() {
    firstnameTF.hideError()
    lastnameTF.hideError()
    emailTF.hideError()
    mobileTF.hideError()
    cityTF.hideError()
    messageTF.hideError()
  }
  
  
  //MARK: - Textfield delegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    let nextTag = textField.tag + 1
    if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
      nextResponder.becomeFirstResponder()
    }
    else {
      textField.resignFirstResponder()
    }
    return false
  }
  
  func sendForm(_ form:Form){
    var notification_token = ""
    if let n = Constants.UserDefaults.object(forKey: "token"){
      if let s = n as? String{
        notification_token = s
      }
    }
    
    let parameters = [
      "id": String(child.id),
      "first_name": form.first_name,
      "last_name": form.last_name,
      "email": form.email,
      "mobile": form.mobile,
      "city": form.city,
      "notification_token": notification_token,
      "via": "iOS",
      "text": form.message]
    
    Constants.UserDefaults.set([
      "first_name": form.first_name,
      "last_name": form.last_name,
      "email": form.email,
      "mobile": form.mobile,
      "city": form.city], forKey: "volunteer")
    
    self.showHUD("Gönderiliyor")
    
    Alamofire.request(Constants.URL.API + "/child/form", method: .post, parameters: parameters).response { response in
      self.hideHUD()
      if let error = response.error {
        let alertController = UIAlertController(title: error.localizedDescription, message: error.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        return
      }
      switch response.response!.statusCode {
      case 404:
        let alert = self.getAlert("Mesaj Gönderilemedi", message:"Böyle bir çocuk bulunmamaktadır.")
        alert.onDismissAction = { _ in self.dismissForm() }
        alert.show()
      case 200:
        let alert = self.getAlert("Tebrikler", message:"Mesajınız tarafımıza ulaşmıştır. İlgili arkadaşlarımız vermiş olduğunuz e-posta adresi üzerinden sizinle iletişime geçecektir. İyilikle Kalın!")
        alert.onDismissAction = { _ in self.dismissForm() }
        alert.show()
      default:
        let alert = self.getAlert("Mesaj Gönderilemedi", message:"Bilinmeyen bir sebepten dolayı mesajının gönderilemedi. Durumu teknik@leyladansonra.com adresine bildirebilirsiniz.")
        alert.onDismissAction = { _ in self.dismissForm() }
        alert.show()
      }
    }
  }
}
