//
//  ViewController.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/27/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController{
    var urlAccepted:String!
    var exTitle: String!
    @IBOutlet weak var exerciseVid: UIWebView!
    @IBOutlet weak var exerTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseVid.isHidden = false
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        exerTitle.textColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0)
        exerTitle.text = exTitle
        exerciseVid.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)

        loadYoutube(videoID: urlAccepted)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadYoutube(videoID:String){
        guard
            let youtubeURL = URL(string:"https://www.youtube.com/embed/\(videoID)")
            else{
              return     
        }
        exerciseVid.loadRequest(URLRequest(url: youtubeURL))
     
    }

//    @IBAction func showText(_ sender: Any) {
//        if descEx.isHidden == true{
//            descEx.isHidden = false
//            exerciseVid.isHidden = true
//        }
//        else{
//            descEx.isHidden = true
//            exerciseVid.isHidden = false
//        }
//    }
}

