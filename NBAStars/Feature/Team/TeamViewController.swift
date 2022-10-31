//
//  TeamViewController.swift
//  NBAStars
//
//  Created by Hafizh Mo on 31/10/22.
//

import UIKit
import Combine

class TeamViewController: UIViewController {
    
    private lazy var compositional = TeamCompositional()
    private lazy var dataSource = TeamDataSource(collectionView: collectionView)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositional)
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = TeamViewModel()
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Team"
        view.backgroundColor = .systemBackground
        
        configureObserver()
        configureUI()
        
        viewModel.fetchMember()
    }
    
    func configureUI() {
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureObserver() {
        viewModel.$teams
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateSnapshot()
            }
            .store(in: &subscriptions)
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Team>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.teams)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

extension TeamViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print(viewModel.teams[indexPath.row].name)
    }
}
