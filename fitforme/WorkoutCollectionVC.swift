//
//  workoutCollectionVC.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/27/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

private let workOutCell = "workOutCell"

//let sendVideoId = NSNotification.Name("sendVideoId")
class WorkoutCollectionVC: UICollectionViewController{
    //MARK: - IVARS -
    var workouts = [Workout]()
    var selectedRow = 0
    //image array for workout cells
    let images = ["stomach","stretch","armwork","peach", "blades"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Select A Workout"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView?.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: workOutCell)
        self.collectionView!.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 20, right: 0)
        // Do any additional setup after loading the view.
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    //
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return workouts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: workOutCell, for: indexPath) as! WorkCell
        cell.layer.borderColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        cell.workLabel?.text = workouts[indexPath.row].name
        cell.workLabel?.backgroundColor = UIColor.white
        cell.workImage?.image = UIImage(named:images[indexPath.row])
        // Configure the cell
        cell.backgroundColor = UIColor.white
        // Configure the cell
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //pass the index path row to a variable that can be passed to the segue
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "workSegue", sender: self)
    }
    //MARK: -Helper Methods- 
    //load and parse the json method
    func loadData(){
        guard let path = Bundle.main.url(forResource: "workout", withExtension: "js")else{
            print("Error: could not find workout.js!")
            return
        }
        do{
            let data = try Data(contentsOf:path, options:[])
            let json = JSON(data:data)
            if json != JSON.null{
                parse(json: json)
            }
            else{
                print("json is null!")
            }
            
            print("json=\(json)")
        }
        catch{
            print("Error: could not initialize the Data() object!")
        }
        
    }
    func parse(json:JSON){
        let array = json["workouts"].arrayValue
        for w in array{
            let name = w["name"].stringValue
            let desc = w["desc"].stringValue
            var url = w["videoId"].stringValue
            if url.isEmpty{
                url = "No url found"
            }
            let type = w["type"].stringValue
            let workout = Workout(title: name, videoId: url, type: type, desc:desc)
            workouts.append(workout)
        }
    }
    //MARK: - Storyboard Segue -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "workSegue"{
            //pass to the workviewcontroller the url and description for label and the name of the exercise
            //to pass to the title label 
            //along with setting the navigation item a different text. 
            let viewDestination = segue.destination as! WorkViewController
            viewDestination.videoUrl = workouts[selectedRow].videoUrl
            viewDestination.descrip = workouts[selectedRow].details
            viewDestination.name = workouts[selectedRow].name
            let backItem = UIBarButtonItem()
            backItem.title = "Workouts"
            navigationItem.backBarButtonItem = backItem
        }
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

class WorkOutCell: UICollectionReusableView{
    
}
