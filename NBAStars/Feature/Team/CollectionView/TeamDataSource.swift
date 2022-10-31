//
//  TeamDataSource.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import UIKit
import CloudKit

final class TeamDataSource: UICollectionViewDiffableDataSource<Int, Team> {
    
    convenience init(collectionView: UICollectionView) {
        
        let memberCell = UICollectionView.CellRegistration<TeamCell, Team> { cell, _, item in
//            cell.name = item.fullname
            cell.image = UIImage(data: item.imageLogo ?? Data())
        }
        
        self.init(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(
                using: memberCell,
                for: indexPath,
                item: itemIdentifier
            )
        }
        
    }
}

