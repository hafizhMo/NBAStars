//
//  PlayerCompositional.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import UIKit

final class PlayerCompositional: UICollectionViewCompositionalLayout {
    
    class func layoutSection(environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layoutSection = NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: environment)
        
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        return layoutSection
    }
    
    convenience init() {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { section, environment in
                return Self.layoutSection(environment: environment)
        }
        
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        self.init(sectionProvider: sectionProvider, configuration: configuration)
    }
}
