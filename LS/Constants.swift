//
//  Constant.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import Foundation


class Constants
{
    static let UserDefaults = NSUserDefaults.standardUserDefaults()
    static let BaseURL = "http://beta.leyladansonra.com/api"
    
    
    struct Menu {
        static let Items:[(title:String, icon:String)] = [("","menuCloseIcon"),("Çocuklar","menuChildrenIcon"),("Biz Kimiz?","menuUsIcon"),("Leyla Kimdir?","menuLeylaIcon"), ("Görseller","menuMediaIcon") ,("Paylaş","menuShareIcon"),("Ayarlar","menuSettingIcon")]
    }
    struct Identifiers
    {
        struct Messages
        {
            static let ReceivedMessage = "receivedMessage"
            static let SentMessage = "sentMessageCell"
        }
        
        struct MainFeed
        {
            static let Header = "MainFeedHeaderView"
            static let Cell = "mainFeedCell"
            static let TextCell = "mainFeedTextCell"
        }
        struct Comments
        {
            static let ImageCell = "commentImageCell"
            static let CommentCell = "commentCell"
            static let CommentHeader = "CommentHeader"
            static let TextCell = "commentTextTableViewCell"
            static let TableView = "commentsTableView"
        }
        struct Notifications
        {
            static let RegularNotifCell = "NotificationTableViewCell"
            static let FriendRequestCell = "NotificationFriendRequestTableViewCell"
        }
        
        struct Instant
        {
            static let ImageViewCell = "ImageCollectionViewCell"
        }
        
        struct UserSettings
        {
            static let PhotoUploadCell = "SettingsPhotoTableViewCell"
            static let UserInfoCell = "UserInfoTableViewCell"
        }
        
        struct PopoverVC
        {
            static let cellReuseID = "makeModelCell"
            static let Following = "Following"
            static let Friends = "Friends"
            static let FriendOfFriends = "Friend of Friends"
            static let All = "All"
        }
        
        struct Chats
        {
            static let ListCell = "messageListCell"
        }
        
        struct Historide
        {
            static let HistorideCell = "historideCollectionViewCell"
            static let Caption = "HistorideCaptionView"
        }
        
        struct Search
        {
            static let SearchCell = "SearchCollectionViewCell"
            static let UserSearchCell = "UserSearchCollectionViewCell"
            static let SearchPredictionCell = "searchPredictionCell"
            static let SearchMediaCell = "mediaCell"
        }
        
        struct UserList
        {
            static let UserList = "userLIstCell"
        }
    }
    
    struct Notifications
    {
        static let SignInSuccess = "sign in success"
        static let ShowInstantPostCamera = "show instant post camera"
        static let TakeInstantPostPicture = "take instant post pic"
        static let DismissCameraView = "dismiss camera view"
        static let UploadingMessage = "Uploading Post..."
        static let UploadedMessage = "Post Succesfully Uploaded!"
        // switch to true to allow denying of friend requests
        static let CanDenyFriendRequests = false
    }
    
    struct Captions
    {
        static let TextPost = "Write a post..."
        static let TextPostLimit = 300
        static let ImagePost = "Add a caption..."
        static let ImagePostLimit = 300
    }
    struct Videos
    {
        static let SecondsLimit = 30
    }
    struct Images
    {
        static let BikeUnselected = UIImage(named: "bike_unselected")
        static let BoatUnselected = UIImage(named: "boat_unselected")
        static let CarUnselected = UIImage(named: "car_unselected")
        static let HeliUnselected = UIImage(named: "heli_unselected")
        static let PlaneUnselected = UIImage(named: "plan_unselected")
        static let RVUnselected = UIImage(named: "RV_unselected")
        static let TruckUnselected = UIImage(named: "truck_unselected")
        static let BikeSelected = UIImage(named: "type_ride_bike")
        static let BoatSelected = UIImage(named: "type_ride_boat")
        static let CarSelected = UIImage(named: "type_ride_car")
        static let HeliSelected = UIImage(named: "type_ride_heli")
        static let MotoSelected = UIImage(named: "type_ride_moto")
        static let PlanSelected = UIImage(named: "type_ride_plane")
        static let RVSelected = UIImage(named: "type_ride_RV")
        static let TruckSelected = UIImage(named: "type_ride_truck")
        static let Messages = UIImage(named:"messages")
        static let Notificatons = UIImage(named:"notification")
        static let Notificatons_Flag = UIImage(named:"notification_flag")
        static let Profile = UIImage(named:"my_profile_header")
        static let Like = UIImage(named:"liked")
        static let Unlike = UIImage(named:"unliked")
        static let UnlikeDark = UIImage(named:"unliked_dark")
        static let Comment = UIImage(named:"comment")
        static let CommentDark = UIImage(named:"comment_dark")
        static let DefaultUser = UIImage(named: "my_profile_header")
        static let MoreNavBar = UIImage(named: "more_header")
        static let Friends = UIImage(named: "friends_selected")
        static let Following = UIImage(named: "following_selected")
        static let FollowMe = UIImage(named: "follow_me_unselected")
        static let AddMe = UIImage(named: "add_me_unselected")
        static let EditProfile = UIImage(named: "edit")
        static let Settings = UIImage(named: "wrench")
    }
}