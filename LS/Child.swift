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

class Child {
    
    // MARK: - Properties
    var id:Int
    var name:String
    var faculty:String
    var post:String
    var slug:String
    var image:Image
    var url:String
    
    // MARK: - Computed Properties
    
    init(){
        id = 0
        name = ""
        faculty = ""
        post = ""
        slug = ""
        url = ""
        image = Image(URL: "", ratio: "")
    }
    
    init(id:Int, name:String, faculty:String, post:String, slug:String, url:String, imageURL:String, imageRatio:String){
        self.id = id;
        self.name = name;
        self.faculty = faculty;
        self.post = post;
        self.slug = slug;
        self.url = url;
        self.image = Image(URL: imageURL, ratio: imageRatio)
    }
    
    func isPortrait()-> Bool {
        return image.ratio == "2/3"
    }
    
}
