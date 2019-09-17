//
//  BrewCollectionViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

private let reuseIdentifier = "brewCell"
private let sectionHeader = "sectionHeader"


class BrewCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    var userGuides: [BrewGuide] = []
    var standardGuides: [BrewGuide] = []
    var separatedGuides: [[BrewGuide]] {
        get {
            return separate(guides: BrewGuideController.shared.guides)
        }
    }
    var selectedGuide: BrewGuide?
    let paddings: CGFloat = 5.0
    let numberOfItemsPerRow: CGFloat = 3.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Brewing Methods"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - paddings * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return BrewGuideController.shared.guides.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return separatedGuides[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BrewCollectionViewCell else { return UICollectionViewCell() }
        // grabs the section (a.k.a. category)
        let category = separatedGuides[indexPath.section]
        // within that category, grabs the guide at that indexPath
        let guide = category[indexPath.item]
        // sets the cells label and image with the associated guide
        cell.methodLabel?.text = guide.method
        cell.methodImageView?.image = guide.methodImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: sectionHeader, for: indexPath) as? SectionHeaderCollectionReusableView else { return UICollectionReusableView() }
        let category = separatedGuides[indexPath.section]
        let guide = category[indexPath.item]
        if guide.userGuide == true {
            sectionHeaderView.categoryTitle = "Your Brewing Guides"
        } else {
            sectionHeaderView.categoryTitle = "Standard Brewing Guides"
        }
        return sectionHeaderView
    }

    // MARK: UICollectionViewDelegate
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = separatedGuides[indexPath.section]
        selectedGuide = category[indexPath.item]
        performSegue(withIdentifier: "toBrewInstructionVC", sender: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrewInstructionVC" {
            guard let destinationVC = segue.destination as? BrewInstructionViewController else { return }
            destinationVC.guide = selectedGuide
        }
    }
    
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
    
    // MARK: - Custom Methods
    func separate(guides: [BrewGuide]) -> [[BrewGuide]] {
        for guide in guides {
            if guide.userGuide == true {
                userGuides.append(guide)
            } else {
                standardGuides.append(guide)
            }
        }
        let separatedGuides = [userGuides, standardGuides]
        return separatedGuides
    }
}
