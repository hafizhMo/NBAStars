//
//  PlayerDataSource.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import UIKit
import CloudKit

final class PlayerDataSource: UICollectionViewDiffableDataSource<Int, Player> {
    
    convenience init(collectionView: UICollectionView) {
        
        let memberCell = UICollectionView.CellRegistration<UICollectionViewListCell, Player> { cell, _, item in
            
            var configuration = cell.defaultContentConfiguration()
            
            configuration.text = item.name
            configuration.textProperties.font = .preferredFont(forTextStyle: .subheadline)
            
            configuration.secondaryText = item.team?.name
            configuration.secondaryTextProperties.color = .secondaryLabel
            configuration.secondaryTextProperties.font = .preferredFont(forTextStyle: .footnote)
            
            configuration.image = UIImage(data: item.imagePhoto ?? Data())
            configuration.imageProperties.maximumSize = CGSize(width: 75, height: 50)
            
            cell.contentConfiguration = configuration
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
