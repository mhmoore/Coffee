//
//  BrewCollectionViewController.swift
//  Coffee
//
//  Created by Michael Moore on 9/15/19.
//  Copyright © 2019 Michael Moore. All rights reserved.
//

import UIKit

class BrewCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    let filledGuides = BrewGuideController.shared.separatedGuides.compactMap ( {$0} )
    let paddings: CGFloat = 5.0
    let numberOfItemsPerRow: CGFloat = 3.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - paddings * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filledGuides.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filledGuides[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeaderCollectionReusableView else { return UICollectionReusableView() }
        let category = filledGuides[indexPath.section]
        let guide = category[indexPath.item]
        if guide.userGuide == true {
            sectionHeaderView.categoryTitle = "Your Brewing Guides"
        } else {
            sectionHeaderView.categoryTitle = "Standard Brewing Guides"
        }
        return sectionHeaderView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brewCell", for: indexPath) as? BrewCollectionViewCell else { return UICollectionViewCell() }
        // grabs the section (a.k.a. category)
        let category = filledGuides[indexPath.section]
        // within that category, grabs the guide at that indexPath
        let guide = category[indexPath.item]
        // sets the cells label and image with the associated guide
        cell.methodLabel?.text = guide.method
        cell.methodImageView?.image = guide.methodImage
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBrewInstructionVC" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let category = filledGuides[indexPath.section]
            let guide = category[indexPath.item]
            guard let destinationVC = segue.destination as? BrewInstructionViewController else { return }
            destinationVC.guide = guide
        }
    }
}
