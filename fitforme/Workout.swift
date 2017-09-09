//
//  Workout.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/29/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import Foundation

class Workout{
    private var videoId:String!
    private var title:String!
    private var type:String!
    private var desc:String!
    init(title:String, videoId:String, type:String, desc:String){
        self.title = title
        self.videoId = videoId
        self.type = type
        self.desc = desc
    }
    public var name:String?{
        return title
    }
    public var videoUrl:String?{
        return videoId
    }
    public var workType:String?{
        return type
    }
    public var details: String{
        return desc
    }
}
