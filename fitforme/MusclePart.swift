//
//  MusclePart.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/29/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import Foundation
//Individual Muscles that get put together
class Muscle{
    //ivar
    private var title: String!
    init(name:String){
        self.title = name
    }
    public var name:String{
        return title
    }
    
}
class MusclePart{
    // ivars 
    var title:String!
    var type:String!
    init(title:String, type:String){
        self.title = title
        self.type = type
    }
    public var name:String{
        return title
    }
}
class MuscleParts{
    static let shared = MuscleParts()
    var legMusc = [MusclePart]()
    var armMusc = [MusclePart]()
    var coreMusc = [MusclePart]()
    private init(){
        
    }
}
