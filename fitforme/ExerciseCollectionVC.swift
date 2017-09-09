//
//  ExerciseCollectionVC.swift
//  fitforme
//
//  Created by Jasmine Ruan (RIT Student) on 4/29/17.
//  Copyright © 2017 Jasmine Ruan (RIT Student). All rights reserved.
//

import UIKit

private let exerciseCell = "exerciseCell"

class ExerciseCollectionVC: UICollectionViewController {
    var currentExercises = [Exercise]()
    var currImages = [String]()
    var selectedRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Exercises"
        let spacing = (collectionView?.bounds.size.width)!/12
        self.collectionView?.backgroundColor = UIColor(red:0.13, green:0.17, blue:0.25, alpha:1.0)
        self.collectionView!.contentInset = UIEdgeInsets(top: 10, left: spacing, bottom: 20, right: spacing)
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
        return currentExercises.count
    }
  //customize cell appearances
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: exerciseCell, for: indexPath) as! ExerciseCell
        cell.layer.borderColor = UIColor(red:1.00, green:0.95, blue:0.65, alpha:1.0).cgColor
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 8.0
        // Configure the cell
        cell.exerciseLabel?.backgroundColor = UIColor.white
        cell.exerciseLabel?.text = currentExercises[indexPath.row].name
        cell.exerciseLabel?.adjustsFontSizeToFitWidth = true
        cell.exerciseImage.image =  UIImage(named:currentExercises[indexPath.row].imageName)
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        
        self.performSegue(withIdentifier: "exerciseSegue", sender: self)
    }
    //MARK: - Storyboard Segue -
    //Pass the url and title of the exercise
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "exerciseSegue"{
            let exerciseDest = segue.destination as! ExerciseViewController
            exerciseDest.urlAccepted = currentExercises[selectedRow].videoUrl
            exerciseDest.exTitle = currentExercises[selectedRow].name
        }
    }
    //MARK: -Storyboard Action Method -
    //When the small favorite button is pressed add to the array of favorites
    @IBAction func favPressed(_ sender: Any) {
        let button = sender as! UIButton
        let indexPat = self.collectionView?.indexPathForView(view: button)
        Exercises.shared.favExercises.append(currentExercises[(indexPat?.row)!])
        let tappedImage = UIImage(named: "faved")
        button.setImage(tappedImage, for: UIControlState.normal)
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
