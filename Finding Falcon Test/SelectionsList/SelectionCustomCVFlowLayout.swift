//
//  SelectionCustomCVFlowLayout.swift
//  Finding Falcon Test
//
//  Created by CS Prasad on 27/07/24.
//

import Foundation
import UIKit

enum CollectionDisplay {
    case inline
    case list
    case grid
}

class SelectionCustomCVFlowLayout : UICollectionViewFlowLayout {
    
    var display : CollectionDisplay = .grid {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    convenience init(display: CollectionDisplay) {
        self.init()
        
        self.display = display
        self.minimumLineSpacing = 16
        self.minimumInteritemSpacing = 10
        self.configLayout()
    }
    
    func configLayout() {
        switch display {
        case .inline:
            self.scrollDirection = .horizontal
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width * 0.9, height: 300)
            }
            
        case .grid:
            
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                let optimisedWidth = (collectionView.frame.width - minimumInteritemSpacing) / 2
                self.itemSize = CGSize(width: optimisedWidth , height: optimisedWidth) // keep as square
            }
            
        case .list:
            self.scrollDirection = .vertical
            if let collectionView = self.collectionView {
                self.itemSize = CGSize(width: collectionView.frame.width - 32 , height: 160)
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
}
