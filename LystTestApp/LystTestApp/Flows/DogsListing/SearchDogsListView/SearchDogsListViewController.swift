//
//  SearchDogsListViewController.swift
//  Lyst Test App
//
//  Created by Mohsin Hussain on 07/08/2021.
//

import UIKit
import LystAssets

class SearchDogsListViewController: MainViewController {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var searchMainView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var searchButton: DisablingButton!
    @IBOutlet weak var searchResultsLabel: UILabel!
    @IBOutlet weak var dogsCollectionView: UICollectionView!
    @IBOutlet weak var emptyListPlaceHolderView: EmptyListPlaceHolderView!
    
    var viewModel = SearchListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performInitialSetup()
        setupTexts()
        setupViewModel()
    }
    
    // MARK: - Actions -
        
    @IBAction func searchAction(_ sender: UIButton) {
        searchBreeds()
    }
    
    @objc private func textInputReturned() {
        searchBreeds()
    }

}

// MARK: - Setup -

extension SearchDogsListViewController {
    
    private func performInitialSetup() {
               
        searchMainView.bottomOnlyCornerRadius(radiusValue: 30)
        shadowView.bottomOnlyCornerRadius(radiusValue: 30)
        shadowView.addSwiftyOutterShadowWithCorner(shadowColor: .lightGray, offSet: .zero, opacity: 0.3, shadowRadius: 7, cornerRadius: 30)

        searchImageView.image = Asset.searchIcon.image
        searchResultsLabel.isHidden = true
        searchTextField.becomeFirstResponder()
      
        searchTextField.addTarget(self, action: #selector(textInputReturned), for: .editingDidEndOnExit)
        enableFieldAndButton(true)
        setupCollectionView()
    }
    
    private func setupTexts() {
        title = "Search Dog Breeds"
        descriptionLabel.text = "Please search for a dog breed"
        searchTextField.placeholder = "Search Breed .."
        emptyListPlaceHolderView.set(description: "No search result found, Please search something else. Sorry for inconvience. ")
        searchButton.setText(disabledText: "SEARCH", enabledText: "SEARCH")
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
    }
    
    private func setupCollectionView() {
        let dogsListCollectionViewCellNib = UINib(nibName: String(describing: DogsListCollectionViewCell.self), bundle: nil)
        dogsCollectionView.register(dogsListCollectionViewCellNib, forCellWithReuseIdentifier: DogsListCollectionViewCell.reuseIdentifier)
        
        dogsCollectionView.dataSource = self
        dogsCollectionView.delegate = self
        dogsCollectionView.reloadData()
    }
}

// MARK: - Functions -

extension SearchDogsListViewController {
    
    func searchBreeds() {
       
        view.endEditing(true)
        guard let queryString = searchTextField.text?.trim(), !queryString.isEmpty else {
            
            if viewModel.getDogs().count > 0 {
                viewModel.resetDogsData()
            }
            return
        }
        viewModel.searchDogs(query: queryString)
    }
    
    func enableFieldAndButton(_ enable: Bool) {
        searchButton.isEnabled = enable
        searchTextField.isEnabled = enable
        dogsCollectionView.isUserInteractionEnabled = enable
    }
}

// MARK: - NAVIGATION -

extension SearchDogsListViewController {
    func navigateToDogDetai(indexPath: IndexPath) {
        if let dog = viewModel.getDog(at: indexPath.row) {
            let dogDetailViewController = DogDetailViewController(nibName: String(describing: DogDetailViewController.self),
                                                                              bundle: nil)
            dogDetailViewController.viewModel.setDog(dog: dog)
            self.navigationController?.pushViewController(dogDetailViewController, animated: false)
        }
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout -

extension SearchDogsListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getDogs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogsListCollectionViewCell",
                                                      for: indexPath) as? DogsListCollectionViewCell
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
        navigateToDogDetai(indexPath: indexPath)
    }
    
    
    func reloadCollectionView() {
        self.dogsCollectionView.reloadData()
    }
    
}

// MARK: - ViewModelUIDelegate -

extension SearchDogsListViewController: ViewModelUIDelegate {
    
    func updateUI(data: Any?, status: StatusEnum?, actionSource: String?) {
        if let status = status {
            switch status {
            case .fetching:
                showActivity()
                
            case .success:
                hideActivity()
                emptyListPlaceHolderView.isHidden = viewModel.getDogs().count > 0
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
