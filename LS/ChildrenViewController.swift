//
//  ChildrenViewController.swift
//  Leyla'dan Sonra
//
//  Created by Mustafa Enes Cakir on 5/16/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import FlatUIKit
import MBProgressHUD
import NVActivityIndicatorView

class ChildrenViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, LSLayoutDelegate, YALContextMenuTableViewDelegate, UITableViewDelegate, UITableViewDataSource, LSContextMenuCellDelegate {
    
    var children:[Child] = []
    var menuItems = Constants.Menu.Items
    var refreshControl:UIRefreshControl?
    @IBOutlet weak var retryButton: LSButton!

    @IBOutlet weak var collectionView: UICollectionView!
    var contextMenuTableView = YALContextMenuTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(ChildrenViewController.loadData), forControlEvents: UIControlEvents.ValueChanged)
        self.collectionView.addSubview(refreshControl!)

        collectionView.backgroundColor = UIColor.clearColor()
        self.title = "Hediye Bekleyen Çocuklar"
        if let layout = collectionView?.collectionViewLayout as? LSLayout { layout.delegate = self }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func retry(sender: AnyObject) {
        loadData()
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        self.contextMenuTableView = YALContextMenuTableView();
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        self.contextMenuTableView.delegate = self
        self.contextMenuTableView.dataSource = self
        //optional - implement menu items layout
        self.contextMenuTableView.menuItemsSide = .Right;
        self.contextMenuTableView.menuItemsAppearanceDirection = .FromTopToBottom;
        self.contextMenuTableView.scrollEnabled = false
        //register nib
        let cellNib = UINib(nibName: "MenuCell", bundle: nil)
        self.contextMenuTableView.registerNib(cellNib, forCellReuseIdentifier: "menuCell")

        let tap = UITapGestureRecognizer(target: self, action: #selector(ChildrenViewController.closeMenu))
        self.contextMenuTableView.backgroundView = UIView(frame: self.contextMenuTableView.bounds)
        self.contextMenuTableView.backgroundView?.addGestureRecognizer(tap)

        
        self.contextMenuTableView.showInView(self.navigationController?.view, withEdgeInsets: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), animated: true)
    }
    
    func closeMenu() {
        self.contextMenuTableView.hidden = true
    }


    // MARK: CollectionViewDelegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return children.count;
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("reuseIdentifier", forIndexPath: indexPath) as! ChildCollectionViewCell
        cell.setChild(children[indexPath.row])
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ChildCollectionViewCell
        if cell.isActive {
            let detailVC = UIStoryboard.detailViewController()
            detailVC.child = children[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        else{
            cell.setActive()
        }
    }

    // MARK: LSLayoutDelegate
    func collectionView(collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: NSIndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let columnWidth = UIScreen.mainScreen().bounds.width/2;
        
        if children[indexPath.row].isPortrait(){
            return  columnWidth * 3 / 2
        }
        else {
            return columnWidth * 3 / 4
        }
    }
    
    // MARK: YALMenuDelegate
    func contextMenuTableView(contextMenuTableView: YALContextMenuTableView!, didDismissWithIndexPath indexPath: NSIndexPath!) {
        switch indexPath.row {
        case 1:
            self.navigationController?.pushViewController(UIStoryboard.usViewController(), animated: true)
        case 2:
            self.navigationController?.pushViewController(UIStoryboard.leylaViewController(), animated: true)
        case 3:
            let textToShare = "Bu gönderi @leyladansonra'nın iOS uygulamasıyla paylaşılmıştır. Siz de çocuklardan anında haberdar olmak için uygulamayı indirin."
            let objectsToShare = [textToShare, UIImage(named:"imageToShare")!]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.presentViewController(activityVC, animated: true, completion: nil)
        case 4:
            self.navigationController?.pushViewController(UIStoryboard.settingsViewController(), animated: true)
        default:
            print("Close")
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contextMenu = tableView as! YALContextMenuTableView
        contextMenu.dismisWithIndexPath(indexPath)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count;
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuCell
        cell.backgroundColor = UIColor.clearColor()
        cell.menuTitleLabel.text = menuItems[indexPath.row].title
        cell.menuImageView.image = UIImage(named: menuItems[indexPath.row].icon)
        cell.delegate = self
        return cell
    }
    

    // MARK: Helpers
    func loadData() {
        retryButton.hidden = true
        self.showHUD("Miniklerimiz yükleniyor")
        Alamofire.request(.GET, Constants.URL.API + "/children").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_,subJson):(String, JSON) in json["children"] {
                        let id = subJson["id"].intValue
                        let name = subJson["first_name"].stringValue
                        let facultyName = subJson["faculty"]["full_name"].stringValue
                        let facultyImage = subJson["faculty"]["slug"].stringValue
                        let facultyCity = subJson["faculty"]["city"].stringValue
                        let meetingDay = subJson["meeting_day"].stringValue
                        let post = subJson["meeting_posts"][0]["text"].stringValue
                        let imageURL = subJson["meeting_posts"][0]["images"][0]["name"].stringValue
                        let imageRatio = subJson["meeting_posts"][0]["images"][0]["ratio"].stringValue
                        let child = Child(id: id, name: name, facultyName: facultyName, facultyImage: facultyImage, facultyCity: facultyCity, meetingDay: meetingDay, post: post, url: "", imageURL: imageURL, imageRatio: imageRatio)
                        self.children.append(child)

                    }
//                    self.waitGeneralChild.text = json["waitGeneralChild"].stringValue
//                    self.roadGeneralChild.text = json["roadGeneralChild"].stringValue
//                    self.reachGeneralChild.text = json["reachGeneralChild"].stringValue
//                    self.deliveredGeneralChild.text = json["deliveredGeneralChild"].stringValue
//                    self.totalChild.text = json["totalChild"].stringValue
                    self.collectionView.reloadData()
                    self.hideHUD()
                    self.refreshControl?.endRefreshing()
                }
            case .Failure(let error):
                let alertController = UIAlertController(title: error.localizedFailureReason, message: error.localizedDescription , preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Tamam", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.collectionView.reloadData()
                self.hideHUD()
                self.refreshControl?.endRefreshing()
                self.retryButton.hidden = false
                return
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
