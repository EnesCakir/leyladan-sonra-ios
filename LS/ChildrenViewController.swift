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

class ChildrenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, LSLayoutDelegate {
    
    var children:[Child] = []
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        collectionView.backgroundColor = UIColor.clearColor()
        self.title = "Hediye Bekleyen Çocuklar"
        if let layout = collectionView?.collectionViewLayout as? LSLayout { layout.delegate = self }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
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
    
    
    // MARK: Helpers
    func loadData() {
        var indicator = UIActivityIndicatorView()
        indicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 75, 75))
        indicator.transform = CGAffineTransformMakeScale(3, 3);
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        print("Starting Download")
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.whiteColor()
        Alamofire.request(.GET, "http://beta.leyladansonra.com/api/children").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for (_,subJson):(String, JSON) in json["children"] {
                        let id = subJson["id"].intValue
                        let name = subJson["first_name"].stringValue
                        let faculty = subJson["faculty"]["full_name"].stringValue
                        let post = subJson["posts"][0]["text"].stringValue
                        let slug = subJson["slug"].stringValue
                        let imageURL = subJson["posts"][0]["images"][0]["name"].stringValue
                        let imageRatio = subJson["posts"][0]["images"][0]["ratio"].stringValue
                        let child = Child(id: id, name: name, faculty: faculty, post: post, slug: slug, url: "", imageURL: imageURL, imageRatio: imageRatio)
                        self.children.append(child)

                    }
                    indicator.stopAnimating()
                    indicator.hidesWhenStopped = true
                    
                    print("Ending Download")
//                    self.waitGeneralChild.text = json["waitGeneralChild"].stringValue
//                    self.roadGeneralChild.text = json["roadGeneralChild"].stringValue
//                    self.reachGeneralChild.text = json["reachGeneralChild"].stringValue
//                    self.deliveredGeneralChild.text = json["deliveredGeneralChild"].stringValue
//                    self.totalChild.text = json["totalChild"].stringValue
                    self.collectionView.reloadData()
                }
            case .Failure(let error):
                print(error)
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
