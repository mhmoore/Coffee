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
    let guides = { () -> [[Guide]] in
        if GuideController.shared.userGuides == nil {
            return [GuideController.shared.standardGuides]
        } else {
            guard let userGuides = GuideController.shared.userGuides else {return [GuideController.shared.standardGuides]}
            return [userGuides, GuideController.shared.standardGuides]
        }
    }
    
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
        return guides().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides()[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeaderCollectionReusableView else { return UICollectionReusableView() }
        let category = guides()[indexPath.section]
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
        let category = guides()[indexPath.section]
        let guide = category[indexPath.item]
        cell.titleLabel?.text = guide.title
        switch guide.method {
        case "CHEMEX":
            cell.methodImageView?.image = UIImage(named: "chemex")
        case "AeroPress":
            cell.methodImageView?.image = UIImage(named: "aeroPress")
        case "Moka Pot":
            cell.methodImageView?.image = UIImage(named: "mokaPot")
        case "French Press":
            cell.methodImageView?.image = UIImage(named: "frenchPress")
        case "Kalita Wave":
            cell.methodImageView?.image = UIImage(named: "kalita")
        case "Hario V60" :
            cell.methodImageView?.image = UIImage(named: "v60")
        default:
            cell.methodImageView?.image = nil
        }
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGuideIntroVC" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let category = guides()[indexPath.section]
            let guide = category[indexPath.item]
            guard let destinationVC = segue.destination as? GuideIntroViewController else { return }
            destinationVC.guide = guide
        }
    }
}
