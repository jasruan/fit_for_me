//
//  FavoriteCollectionVC.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/29/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

private let favCell = "favCell"

class FavoriteCollectionVC: UICollectionViewController {
    var fav = Exercises.shared.favExercises
    var selectedRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Favorite Exercises"
        self.collectionView?.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let spacing = (collectionView?.bounds.size.width)!/12
        self.collectionView!.contentInset = UIEdgeInsets(top: 10, left: spacing, bottom: 20, right: spacing)
        //save to file when the view is loaded is nothing exists or load the file when the view is loaded
        let fileName = "favExercises.archive"
        let pathToFile = FileManager.filePathInDocumentsDirectory(fileName: fileName)
        if FileManager.default.fileExists(atPath: pathToFile.path){
            Exercises.shared.favExercises = NSKeyedUnarchiver.unarchiveObject(withFile: pathToFile.path) as! [Exercise]
        }
        else{
            saveExercises()
        }
                // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView?.reloadData()
        saveExercises()
       
    }
    //Remove the favorited cell from the view and the array of faved exercises!
    @IBAction func remove(_ sender: Any) {
        let button = sender as! UIButton
        let indexPat = self.collectionView?.indexPathForView(view: button)
        Exercises.shared.favExercises.remove(at: (indexPat?.row)!)
        //Exercises.shared.favImages.remove(at: (indexPat?.row)!)
        collectionView?.deleteItems(at: [indexPat as! IndexPath])
        saveExercises()
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
        return Exercises.shared.favExercises.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favCell, for: indexPath) as! FavoriteCell
        cell.layer.borderColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.favLabel?.text = Exercises.shared.favExercises[indexPath.row].name
        cell.favImage.image = UIImage(named:Exercises.shared.favExercises[indexPath.row].imageName)
        // Configure the cell
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        self.performSegue(withIdentifier: "favExSegue", sender: self)
    }
    //MARK: - Storyboard Segue -
    //Send to the exercise view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favExSegue"{
            let exerciseDest = segue.destination as! ExerciseViewController
            exerciseDest.urlAccepted = Exercises.shared.favExercises[selectedRow].videoUrl
            exerciseDest.exTitle = Exercises.shared.favExercises[selectedRow].name
        }
    }
    //MARK: - Methods - 
    //save exercises to a file so it can be unwrapped later 
    func saveExercises(){
        let pathToFile = FileManager.filePathInDocumentsDirectory(fileName: "favExercises.archive")
        let success = NSKeyedArchiver.archiveRootObject(Exercises.shared.favExercises, toFile: pathToFile.path)
        print("Saved = \(success) to \(pathToFile)")
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


