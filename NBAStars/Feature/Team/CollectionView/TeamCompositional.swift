//
//  TeamCompositional.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import UIKit

final class TeamCompositional: UICollectionViewCompositionalLayout {
    
    class func layoutSection() -> NSCollectionLayoutSection {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .estimated(1)
        )
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        let groupLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: layoutSize.heightDimension
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayoutSize, repeatingSubitem: layoutItem, count: 2)
        group.interItemSpacing = .fixed(20)
        
        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        layoutSection.interGroupSpacing = 16
        
        return layoutSection
    }
    
    convenience init() {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, _ in
                return Self.layoutSection()
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        self.init(sectionProvider: sectionProvider, configuration: configuration)
    }
}
