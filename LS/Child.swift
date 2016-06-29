//
//  Child.swift
//  LS
//
//  Created by Mustafa Enes Cakir on 6/12/16.
//  Copyright © 2016 EnesCakir. All rights reserved.
//

import UIKit

struct Image {
    var URL:String
    var ratio:String
}

struct Faculty {
    var name:String
    var image:String
    var city:String
}


class Child {
    
    // MARK: - Properties
    var id:Int
    var name:String
    var faculty:Faculty
    var post:String
    var meetingDay:String
    var image:Image
    var url:String
    
    // MARK: - Computed Properties
    
    init(){
        id = 0
        name = ""
        faculty = Faculty(name: "", image: "", city: "")
        meetingDay = ""
        post = ""
        url = ""
        image = Image(URL: "", ratio: "")
    }
    
    init(id:Int, name:String, facultyName:String, facultyImage:String, facultyCity:String, meetingDay:String, post:String, url:String, imageURL:String, imageRatio:String){
        self.id = id;
        self.name = name;
        self.faculty = Faculty(name: facultyName, image: facultyImage, city: facultyCity)
        self.meetingDay = meetingDay;
        self.meetingDay.removeRange( self.meetingDay.rangeOfString("00:00:00")! )
        self.post = post;
        self.url = url;
        self.image = Image(URL: imageURL, ratio: imageRatio)
    }
    
    func isPortrait()-> Bool {
        return image.ratio == "2/3"
    }
    
}
