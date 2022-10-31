//
//  ViewController.swift
//  NBAStars
//
//  Created by Hafizh Mo on 23/10/22.
//

import UIKit
import Combine

class PlayerViewController: UIViewController {
    
    private lazy var compositional = PlayerCompositional()
    private lazy var dataSource = PlayerDataSource(collectionView: collectionView)
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: compositional)
    
    private lazy var loading = LoadingView(style: .medium)
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel = PlayerViewModel()
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemBackground
        
        configureObserver()
        configureUI()
        
        viewModel.fetchMember()
    }
    
    func configureUI() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        view.addSubview(loading)
        loading.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
    }
    
    func configureObserver() {
        viewModel.$players
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateSnapshot()
            }
            .store(in: &subscriptions)
        
        viewModel.$filteredPlayers
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.updateSearchSnapshot()
            }
            .store(in: &subscriptions)
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink { [weak self] state in
                switch state {
                case .initialize:
                    return
                case .onLoading:
                    self?.startLoading()
                case .onSuccess:
                    self?.finishLoading()
                case .onFailure:
                    self?.finishLoading()
                    self?.showError()
                }
            }
            .store(in: &subscriptions)
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Player>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.players)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func updateSearchSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Player>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.filteredPlayers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func startLoading() {
        collectionView.isUserInteractionEnabled = false
        
        loading.isHidden = false
        loading.startAnimating()
    }
    
    func finishLoading() {
        collectionView.isUserInteractionEnabled = true
        
        loading.stopAnimating()
    }
    
    func showError() {
        let alertController = UIAlertController(title: "Error", message: "No Data Found", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension PlayerViewController: UISearchResultsUpdating, UICollectionViewDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text, keyword.count > 0 else {
            viewModel.fetchMember()
            return
        }
        viewModel.filterPlayer(keyword: keyword.lowercased())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if searchController.isActive {
            print(viewModel.filteredPlayers[indexPath.row].name)
        } else {
            print(viewModel.players[indexPath.row].name)
        }
    }
}
