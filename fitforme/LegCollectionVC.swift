//
//  LegCollectionVC.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 5/12/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

private let musclePartCell = "musclePartCell"

class LegCollectionVC: UICollectionViewController {
    var currMuscle = [MusclePart]()
    var currImages = [String]()
    var currEx = [Exercise]()
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        let spacing = (collectionView?.bounds.size.width)!/12
        self.collectionView?.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        self.collectionView!.contentInset = UIEdgeInsets(top: 20, left: spacing, bottom: 20, right: spacing)
        loadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return currMuscle.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: musclePartCell, for: indexPath) as! MusclePartCell
        cell.layer.borderColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.musclePartImage.image = UIImage(named:currImages[indexPath.row])
        // Configure the cell
        cell.musclePartLabel?.text = currMuscle[indexPath.row].name
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "exercSegue", sender: self)
    }
    //MARK: - Storyboard Segue -
    //Passing in which exercises based on their type value
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ExerciseCollectionVC
        if segue.identifier == "exercSegue"{
            switch selectedIndex{
            case 0:
                dest.currentExercises = Exercises.shared.gluteEx
                break
            case 1:
                dest.currentExercises = Exercises.shared.hamstringEx
                break
            case 2:
                dest.currentExercises = Exercises.shared.quadEx
                break
            case 3:
                dest.currentExercises = Exercises.shared.calfEx
                break
            default:
                break
            }
        }
    }
    //MARK: -Helper Methods-
    //load and parse the json method
    func loadData(){
        guard let pathTwo = Bundle.main.url(forResource: "legs", withExtension: "js")else{
            print("Error: could not find legs.js!")
            return
        }
        do{
            let data = try Data(contentsOf:pathTwo, options:[])
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
        let array = json["legs"].arrayValue
        for c in array{
            let name = c["name"].stringValue
            let equip = c["equip"].stringValue
            let url = c["url"].stringValue
            let type = c["muscle"].stringValue
            let img = c["image"].stringValue
            let exercises = Exercise(title: name, videoId: url, equip: equip, type: type, imageId:img)
            //add elements to array and then sort it out afterwards
            currEx.append(exercises)
            Exercises.shared.gluteEx = currEx.filter(){ curr in
                (curr.muscle?.contains("glutes"))!
            }
            Exercises.shared.hamstringEx = currEx.filter(){
                curr in (curr.muscle?.contains("hamstring"))!
            }
            Exercises.shared.quadEx = currEx.filter(){
                curr in (curr.muscle?.contains("quads"))!
            }
            Exercises.shared.calfEx = currEx.filter(){
                curr in (curr.muscle?.contains("calf"))!
            }
        } // end of loop
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

