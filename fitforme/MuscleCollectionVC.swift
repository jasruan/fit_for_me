//
//  muscleCollectionVC.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/27/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

private let muscleCell = "muscleCell"

class MuscleCollectionVC: UICollectionViewController{
    let image = ["core","arms","legs"]
    let armImages = ["biceps", "triceps", "shoulders","forearms", "chest"]
    let legImages = ["glutes", "hamstring", "quads", "calves"]
    let coreImages = ["oblique", "lowerab","upperab", "back"]
    var muscle = [Muscle]()
    var legMuscleParts = [MusclePart]()
    var coreMuscleParts = [MusclePart]()
    var armMuscleParts = [MusclePart]()
    var selectedIndex = 0
    @IBOutlet weak var muscleLabel: UILabel!
    
    override func viewDidLoad() {
        navigationItem.title = "Select A Group"
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView!.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        // Register cell classes
        // self.collectionView!.register(MuscleCell.self, forCellWithReuseIdentifier: muscleCell)
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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return muscle.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: muscleCell, for: indexPath) as! MuscleCell
        cell.layer.borderColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        cell.muscleLabel?.text = muscle[indexPath.row].name
        cell.muscleLabel?.backgroundColor = UIColor.white
        cell.muscleImage.image = UIImage(named:image[indexPath.row])
        // Configure the cell
        cell.backgroundColor = UIColor.white
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
//        headerView.backgroundColor = UIColor.black
//        return headerView
//        
//    }
    //Connect to different segues based on clicked cell 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        switch indexPath.row{
        case 0:
            self.performSegue(withIdentifier: "coreSegue", sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: "armSegue", sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: "legSegue", sender: self)
            break
        default:
            break
        }

    }
    //MARK: - Storyboard Segue -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch selectedIndex{
            case 0:
                let coreDest = segue.destination as! CoreCollectionVC
                coreDest.currMuscle = MuscleParts.shared.coreMusc
                coreDest.currImages = coreImages
                break
            case 1:
                let armDest = segue.destination as! ChestArmCollectionVC
                armDest.currMuscle = MuscleParts.shared.armMusc
                armDest.currImages = armImages
                break
            case 2:
                let legDest = segue.destination as! LegCollectionVC
                legDest.currMuscle = MuscleParts.shared.legMusc
                legDest.currImages = legImages
                break
            default:
                break
            }
            
        
        let backItem = UIBarButtonItem()
        backItem.title = "Group"
        navigationItem.backBarButtonItem = backItem        
    }
    //MARK: -Helper Methods-
    //load and parse the json method
    func loadData(){
        guard let path = Bundle.main.url(forResource: "group", withExtension: "js")else{
            print("Error: could not find group.js!")
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
        
        guard let pathTwo = Bundle.main.url(forResource: "muscleGroups", withExtension: "js")else{
            print("Error: could not find muscleGroups.js!")
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
        let array = json["muscleCollect"].arrayValue
        for m in array{
            let name = m["name"].stringValue
            
            let muscles = Muscle(name: name)
            muscle.append(muscles)
        }
        let muscArray = json["muscleGroups"].arrayValue
        for g in muscArray{
            let name = g["name"].stringValue
            let type = g["type"].stringValue
            
            let armMuscles = MusclePart(title: name, type: type)
            let coreMuscles = MusclePart(title: name, type: type)
            let legMuscles = MusclePart(title: name, type: type)
            
            switch type {
            case "arms":
                armMuscleParts.append(armMuscles)
                break
            case "core":
                coreMuscleParts.append(coreMuscles)
                break
            case "legs":
                legMuscleParts.append(legMuscles)
                break
            default:
                break
            }
        }
        MuscleParts.shared.armMusc = armMuscleParts
        MuscleParts.shared.coreMusc = coreMuscleParts
        MuscleParts.shared.legMusc = legMuscleParts
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

