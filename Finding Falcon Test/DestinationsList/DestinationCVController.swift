//
//  DestinationCVController.swift
//  Finding Falcon Test
//
//  Created by CS Prasad on 25/07/24.
//

import UIKit

private let reuseIdentifier = "Cell"

class DestinationCVController: UICollectionViewController {
    private let layout: UICollectionViewLayout
    private let dataSource: DestinationDataSource
    
    // MARK: - NSCoding
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        registerCells()
        collectionView.collectionViewLayout = layout
        collectionView.dataSource = dataSource
        collectionView.reloadData()
    }
    
    // MARK: - PhotosCollectionViewController
    
    /// Creates an instance of `PhotosCollectionViewController`.
    /// - Parameters:
    ///   - collectionViewLayout: The layout to apply to the collection view.
    ///   - dataSource: The data source of the collection view.
    ///   - coder: An unarchiver object.
    init?(collectionViewLayout: UICollectionViewLayout, dataSource: DestinationDataSource, coder: NSCoder) {
        self.layout = collectionViewLayout
        self.dataSource = dataSource
        
        super.init(coder: coder)
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
    }
}

// only used for the flow layout example 👇

extension DestinationCVController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
