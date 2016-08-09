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

class ChildrenViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, LSLayoutDelegate {
    
    var children:[Child] = []
    var refreshControl:UIRefreshControl?
    var leylaRefreshView: UIView!
    var refreshImage: UIImageView!
    var isAnimatingRefresh = false
    
    @IBOutlet weak var retryButton: LSButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(ChildrenViewController.loadData), forControlEvents: UIControlEvents.ValueChanged)
        refreshControl?.backgroundColor = UIColor.primaryColor()
        refreshControl?.tintColor = UIColor.whiteColor()
        self.collectionView.addSubview(refreshControl!)

        loadCustomRefreshContents()

        collectionView.backgroundColor = UIColor.clearColor()
        self.navigationItem.title = "Hediye Bekleyen Minikler"
        if let layout = collectionView?.collectionViewLayout as? LSLayout { layout.delegate = self }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func retry(sender: AnyObject) {
        loadData()
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
    
    // MARK: ScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -64 {
            if(!isAnimatingRefresh){
                animateRefresh()
            }
        }
    }

    // MARK: Helpers
    func animateRefresh(){
        isAnimatingRefresh = true
        UIView.animateWithDuration(0.35, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.refreshImage.alpha = 0
            }, completion: { (finished) -> Void in
                UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.refreshImage.alpha = 1
                    
                    }, completion: { (finished) -> Void in
                        if self.refreshControl!.refreshing {
                            self.animateRefresh()
                        }
                        else{
                            self.isAnimatingRefresh = false
                        }
                })
        })
        
    }
    
    func loadCustomRefreshContents() {
        let refreshContents = NSBundle.mainBundle().loadNibNamed("LeylaRefresh", owner: self, options: nil)
        leylaRefreshView = refreshContents[0] as! UIView
        leylaRefreshView.frame = refreshControl!.bounds
        leylaRefreshView.backgroundColor = UIColor.primaryColor()
        refreshImage = leylaRefreshView.viewWithTag(1) as! UIImageView
        refreshControl?.addSubview(leylaRefreshView)
    }
    
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
