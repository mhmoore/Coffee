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
    var guides: [[Guide]] {
        if GuideController.shared.userGuides == nil {
            return [GuideController.shared.standardGuides]
        } else {
            guard let userGuides = GuideController.shared.userGuides, !userGuides.isEmpty else {return [GuideController.shared.standardGuides]}
            return [userGuides, GuideController.shared.standardGuides]
        }
    }
    
    let paddings: CGFloat = 2.0
    let numberOfItemsPerRow: CGFloat = 3.0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        GuideController.shared.loadFromPersistentStorage()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        super.setEditing(false, animated: true)
    }
    
    // MARK: - Custom Methods
    func setupUI() {
        view.backgroundColor = .background
        collectionView.backgroundColor = .background
        navigationItem.rightBarButtonItem = editButtonItem
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - paddings * (numberOfItemsPerRow - 1)) / numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return guides.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return guides[section].count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as? SectionHeaderCollectionReusableView else { return UICollectionReusableView() }
        
        let category = guides[indexPath.section]
        if guides[indexPath.section].count != 0 {
            let guide = category[indexPath.item]
            if guide.userGuide == true {
                sectionHeaderView.categoryTitle = "Your Brewing Guides"
            } else {
                sectionHeaderView.categoryTitle = "Standard Brewing Guides"
            }
        } else {
            sectionHeaderView.categoryTitle = ""
        }
        sectionHeaderView.backgroundColor = .lightGray
        return sectionHeaderView
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "brewCell", for: indexPath) as? BrewCollectionViewCell else { return UICollectionViewCell() }
        let category = guides[indexPath.section]
        let guide = category[indexPath.item]
        cell.guide = guide
        cell.delegate = self
        cell.backgroundColor = .background
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            if let cell = collectionView.cellForItem(at: indexPath) as? BrewCollectionViewCell {
                cell.isEditing = editing
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGuideIntroVC" {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let category = guides[indexPath.section]
            let guide = category[indexPath.item]
            guard let destinationVC = segue.destination as? GuideIntroViewController else { return }
            destinationVC.guide = guide
        }
    }
}

extension BrewCollectionViewController: BrewCellDelegate {
    func delete(cell: BrewCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            let category = guides[indexPath.section]
            let guide = category[indexPath.row]
            GuideController.shared.remove(guide: guide)
            if guides.count > 1 {
                collectionView.deleteItems(at: [indexPath])
            } else {
                collectionView.reloadData()
            }
        }
    }
}
