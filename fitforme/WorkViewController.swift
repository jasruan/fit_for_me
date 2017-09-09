//
//  WorkViewController.swift
//  fitforme
//
//  Created by Student on 5/1/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

class WorkViewController: UIViewController {
    //MARK: -IVARS & OUTLETS - 
    var videoUrl: String!
    @IBOutlet weak var workVid: UIWebView!
    @IBOutlet weak var descLab: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleText: UIBarButtonItem!
    var name:String!
    var descrip:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleText.title = "Show Text"
        workVid.isHidden = false
        descLab.isHidden = true
        self.view.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        loadYoutube(videoID: videoUrl)
        workVid.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        descLab.text = descrip
        descLab.numberOfLines = 0
        titleLabel.textColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0)
        titleLabel.text = name
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.workVid.loadHTMLString("", baseURL: nil)
    }
    //pass in the string from the json file that's passed from the segue to load the video
    func loadYoutube(videoID:String){
        guard
            let youtubeURL = URL(string:"https://www.youtube.com/embed/\(videoID)")
            else{
                return
        }
        workVid.allowsInlineMediaPlayback = true
        workVid.loadRequest(URLRequest(url: youtubeURL))
        
    }
    //MARK: -Storyboard Action Method -
    //Toggles the show text button between the uiwebview and label to show
    @IBAction func toggleText(_ sender: Any) {
        if descLab.isHidden == true{
            toggleText.title = "Show Video"
            descLab.isHidden = false
            workVid.isHidden = true
        }
        else{
            toggleText.title = "Show Text"
            descLab.isHidden = true
            workVid.isHidden = false
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
//extension String {
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
//        
//        return boundingBox.height
//    }
//}
