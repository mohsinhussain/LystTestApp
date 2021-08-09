//
//  DogsListViewController.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import LystAssets

class DogsListViewController: MainViewController {
    
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    var viewModel = DogsListViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchDogsList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTexts()
        setupCollectionView()
        setupViewModel()
    }
    
    override func autoRefresh() {
        super.autoRefresh()
      
        if UIWindow.key?.topViewController() is DogsListViewController {
            viewModel.fetchDogsList()
        }
    }
    // MARK: - Actions -
    
    @objc func searchAction() {
        navigateToSearchDogs()
    }

}


// MARK: - Setup -

extension DogsListViewController {
    
    private func setupNavigationBar() {
        addTopRightButton(with: Asset.searchIcon.image, target: self, action: #selector(searchAction))
    }
    
    private func setupTexts() {
        title = "DOGS"
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        let dogsListCollectionViewCellNib = UINib(nibName: String(describing: DogsListCollectionViewCell.self), bundle: nil)
        dogsCollectionView.register(dogsListCollectionViewCellNib, forCellWithReuseIdentifier: DogsListCollectionViewCell.reuseIdentifier)
        
        dogsCollectionView.dataSource = self
        dogsCollectionView.delegate = self
//        if let layout = merchantActionsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.minimumLineSpacing = 0
//            merchantActionsCollectionView.collectionViewLayout = layout
//        }
        dogsCollectionView.reloadData()
    }

}

// MARK: - ViewModelUIDelegate -

extension DogsListViewController: ViewModelUIDelegate {
    
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?) {
        if let status = status {
            switch status {
            case .fetching:
                showActivity()
                
            case .success:
                hideActivity()
                dogsCollectionView.reloadData()
                
            case .error(let message):
                hideActivity()
                (UIApplication.shared.keyWindow!.rootViewController as? UINavigationController)?.present(display(errorTitle: message), animated: true, completion: nil)
                
                
            case .dismiss:
                hideActivity()
                dismiss()
            }
        }
    }
    
}


// MARK: - NAVIGATION -

extension DogsListViewController {
    func navigateToSearchDogs() {
        let searchDogsListViewController = SearchDogsListViewController(nibName: String(describing: SearchDogsListViewController.self),
                                                                          bundle: nil)
        self.navigationController?.pushViewController(searchDogsListViewController, animated: false)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension DogsListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDogs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogsListCollectionViewCell",
                                                      for: indexPath) as? DogsListCollectionViewCell
//        let boxAction = viewModel.merchantActions[indexPath.row]
        if let dog = viewModel.getDog(at: indexPath.row) {
            cell?.configure(with: dog)
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 10) / 2)
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        actionsHandling(at: indexPath)
    }
    
    
    func reloadCollectionView() {
        self.dogsCollectionView.reloadData()
    }
    
}
