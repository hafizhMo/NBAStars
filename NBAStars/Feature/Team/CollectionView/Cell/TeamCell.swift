//
//  TeamCell.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import UIKit

final class TeamCell: UICollectionViewCell {
    
    var name: String? {
        willSet {
            label.text = newValue
        }
    }
    
    var image: UIImage? {
        willSet {
            imageView.image = newValue
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(imageView.snp.width)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView).offset(12)
            make.right.equalTo(imageView).offset(-12)
            make.bottom.equalTo(imageView).offset(-12)
        }
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
