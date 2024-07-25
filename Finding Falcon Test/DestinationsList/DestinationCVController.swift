//
//  DestinationCVController.swift
//  Finding Falcon Test
//
//  Created by CS Prasad on 25/07/24.
//

import UIKit

class DestinationCVController: UICollectionViewController {
    var layout: UICollectionViewLayout? = nil
    var dataSource: DestinationDataSource? = nil
    
    // MARK: - NSCoding
    
    
    let compositionalLayout: UICollectionViewCompositionalLayout = {
        let fraction: CGFloat = 1 / 2
        let inset: CGFloat = 2.5
        
        // Item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fraction), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(fraction))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // Supplementary Item
        let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerItemSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    let ds = [
        Destination(groupId:1, id: 1, image: UIImage(named: "Donlon") ?? UIImage(), vehicle: "Space pod", planet: "Donlon"),
        Destination(groupId:1, id: 2, image: UIImage(named: "Enchai") ?? UIImage(), vehicle: "Space rocket", planet: "Enchai"),
        Destination(groupId:2, id: 3, image: UIImage(named: "Jebing") ?? UIImage(), vehicle: "Space shuttle", planet: "Jebing"),
        Destination(groupId: 2, id: 4, image: UIImage(named: "Sapir") ?? UIImage(), vehicle: "Space ship", planet: "Sapir"),
        Destination(groupId: 3, id: 5, image: UIImage(named: "Lerbin") ?? UIImage(), vehicle: "Space", planet: "Lerbin"),
        Destination(groupId: 3, id: 6, image: UIImage(named: "Donlon") ?? UIImage(), vehicle: "Space", planet: "Pingasor"),
        Destination(groupId: 4, id: 7, image: UIImage(named: "Donlon") ?? UIImage(), vehicle: "Space pod", planet: "Donlon"),
        Destination(groupId: 4, id: 8, image: UIImage(named: "Enchai") ?? UIImage(), vehicle: "Space rocket", planet: "Enchai")]
    
    
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        registerCells()
        self.layout = compositionalLayout
        collectionView.collectionViewLayout = layout ?? UICollectionViewLayout()
        print(layout?.description)
        let DS = DestinationDataSource(destination: ds, sectionStyle: .byGroup(maximumItemsPerGroup: 2, maximumNumberOfGroup: nil))
        self.dataSource = DS
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.reloadData()
        print(dataSource?.sections[0].items[0].vehicle)
    }
    
    // MARK: - PhotosCollectionViewController
    
    /// Creates an instance of `PhotosCollectionViewController`.
    /// - Parameters:
    ///   - collectionViewLayout: The layout to apply to the collection view.
    ///   - dataSource: The data source of the collection view.
    ///   - coder: An unarchiver object.
    ///
//    init?(collectionViewLayout: UICollectionViewLayout, dataSource: DestinationDataSource, coder: NSCoder) {
//        self.layout = collectionViewLayout
//        self.dataSource = dataSource
//
//        super.init(coder: coder)
//    }
    
    private func registerCells() {
//        collectionView.register(UINib(nibName: "DestinationCell", bundle: nil), forCellWithReuseIdentifier: "DestinationCell")
        collectionView.register(UINib(nibName: "HeaderSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "header", withReuseIdentifier: "HeaderSupplementaryView")
        collectionView.register(UINib(nibName: "NewBannerSupplementaryView", bundle: nil), forSupplementaryViewOfKind: "new-banner", withReuseIdentifier: "NewBannerSupplementaryView")
    }
}

// only used for the flow layout example 👇

extension DestinationCVController: UICollectionViewDelegateFlowLayout {

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 2
        let spacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
    }
}
