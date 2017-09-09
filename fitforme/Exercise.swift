//
//  Exercise.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/29/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import Foundation
//Make the Exercise class follow nscoding protocols so the favorites and images that go with it can be saved 
//after deletion of app or closing of app
class Exercise:NSObject, NSCoding{
    //MARK : -IVARS -
    private var videoId:String!
    private var title:String!
    private var equip:String!
    private var type:String!
    private var imageId:String!
    init(title:String, videoId:String,equip:String, type:String, imageId:String){
        self.title = title
        self.videoId = videoId
        self.equip = equip
        self.type = type
        self.imageId = imageId
    }
    //MARK: - Public Ivar getters -
    public var name:String?{
        return title
    }
    public var videoUrl:String?{
        return videoId
    }
    public var equipment:String?{
        return equip
    }
    public var muscle:String?{
        return type
    }
    public var imageName:String{
        return imageId
    }
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(videoId, forKey:"videoId")
        aCoder.encode(imageId, forKey:"imageId")
    }
    
    required init(coder aDecoder:NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        videoId = aDecoder.decodeObject(forKey: "videoId") as! String
        imageId = aDecoder.decodeObject(forKey: "imageId") as! String
    }

}
//Arrays of exercises that will be passed around 
class Exercises{
    static let shared = Exercises()
    var bicepEx = [Exercise]()
    var tricepEx = [Exercise]()
    var shouldersEx = [Exercise]()
    var foreEx = [Exercise]()
    var chestEx = [Exercise]()
    var obliqueEx = [Exercise]()
    var lowerAbEx = [Exercise]()
    var upperAbEx = [Exercise]()
   var backEx = [Exercise]()
    var gluteEx = [Exercise]()
    var hamstringEx = [Exercise]()
    var quadEx = [Exercise]()
    var calfEx = [Exercise]()
    var favExercises = [Exercise]()
    private init(){
        
    }
    
}
