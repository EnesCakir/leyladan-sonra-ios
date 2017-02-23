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
import Alamofire
import SwiftyJSON

class DetailViewController: BaseViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var giftButton: UIButton!
  @IBOutlet weak var facultyLogo: UIImageView!
  
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var meetingLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  
  // MARK: - Properties
  var child:Child?
  var childID:Int = 0

  // MARK: - Lifecycles
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupHeader()
    
    let backItem = UIBarButtonItem()
    backItem.title = "Geri"
    navigationItem.backBarButtonItem = backItem
    
    if child == nil {
      loadData()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - IBActions
  @IBAction func showForm(_ sender: AnyObject) {
    if let child = child {
      let formVC = UIStoryboard.formViewController()
      formVC.child = child
      self.navigationController?.pushViewController(formVC, animated: true)
    }
  }
  
  // MARK: - Setups
  func setupUI(){
    let buttonTitle = NSMutableAttributedString(string: "DİLEĞİ GERÇEKLEŞTİR")
    buttonTitle.addAttributes([ NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 16)! ], range: NSMakeRange(0, buttonTitle.length))
    buttonTitle.addAttribute(NSKernAttributeName, value: 5.0, range: NSMakeRange(0, buttonTitle.length))
    buttonTitle.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range: NSMakeRange(0, buttonTitle.length))
    giftButton.setAttributedTitle(buttonTitle, for: UIControlState())
    giftButton.backgroundColor = UIColor.primaryDarkColor()
    
    if let child = child {
      self.title = child.name
      textView.text = child.post.htmlToString.string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
      cityLabel.text = child.faculty.city
      meetingLabel.text = Date.dateToNSDate(child.meetingDay).toLabel()
      statusLabel.text = child.wish
      facultyLogo.af_setImage(
        withURL: URL(string: Constants.URL.Faculty(child.faculty.image))!,
        placeholderImage: UIImage(named: "ls_logo"),
        imageTransition: .crossDissolve(0.2))
    }
  }
  
  func setupHeader(){
    self.automaticallyAdjustsScrollViewInsets = false
    if let child = child {
      let headerView = Bundle.main.loadNibNamed("ChildDetailHeader", owner: self, options: nil)?.first as? ChildDetailHeader
      headerView?.setChild(child)
      self.scrollView.parallaxHeader.view = headerView
      self.scrollView.parallaxHeader.height = 400
      self.scrollView.parallaxHeader.mode = MXParallaxHeaderMode.fill
      self.scrollView.parallaxHeader.minimumHeight = 0
    }
  }
  
  // MARK: - Helpers
  func loadData() {
    self.showHUD("Miniğimiz yükleniyor")
    Alamofire.request(Constants.URL.API + "/child/" + String(childID)).validate().responseJSON { response in
      switch response.result {
      case .success:
        if let value = response.result.value {
          let json = JSON(value)
          debugPrint(json)
          let id = json["id"].intValue
          let name = json["first_name"].stringValue
          let wish = json["wish"].stringValue
          let facultyName = json["faculty"]["full_name"].stringValue
          let facultyImage = json["faculty"]["slug"].stringValue
          let facultyCity = json["faculty"]["city"].stringValue
          let meetingDay = json["meeting_day"].stringValue
          let post = json["meeting_posts"][0]["text"].stringValue
          let imageURL = json["meeting_posts"][0]["images"][0]["name"].stringValue
          let imageRatio = json["meeting_posts"][0]["images"][0]["ratio"].stringValue
          self.child = Child(id: id, name: name, wish: wish, facultyName: facultyName, facultyImage: facultyImage, facultyCity: facultyCity, meetingDay: meetingDay, post: post, url: "", imageURL: imageURL, imageRatio: imageRatio)
          self.setupUI()
          self.setupHeader()
          self.hideHUD()
        }
      case .failure(let error):
        let alertController = UIAlertController(title: error.localizedDescription, message: error.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
        self.hideHUD()
        return
      }
    }
  }

  
}
