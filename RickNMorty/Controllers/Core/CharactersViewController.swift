//
//  CharactersViewController.swift
//  test
//
//  Created by Arda Büyükhatipoğlu on 30.11.2023.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    //Constants and Variables
    var characters: [Character]?
    var page = 1
    var numberOfPages: Int?
    
    lazy var collectionView: UICollectionView = {
        
        let itemWidth = (self.view.frame.width - 50) / 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumInteritemSpacing = 10
        
        layout.footerReferenceSize = CGSize(width: self.view.frame.width, height: 50)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //register:
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.identifier)
        collectionView.register(CollectionViewFooterButtons.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: CollectionViewFooterButtons.identifier)

        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
        fetchCharacters()
    }
    
    private func configure() {
        view.backgroundColor = Colors.mediumBlue
        title = "Characters"
        
        navigationController?.navigationBar.barTintColor = Colors.darkBlue
        tabBarController?.tabBar.barTintColor = Colors.mediumBlue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func fetchCharacters() {
        
        APICaller.fetchData(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                
                switch result {
                case .success(let resultData):
                    self.characters = resultData.results
                    self.numberOfPages = resultData.info.pages
                    collectionView.reloadData()
                    collectionView.scroll(to: .top, animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

//MARK: CollectionView Methods
extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let unwrappedCharacters = characters  {
            return unwrappedCharacters.count
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.identifier, for: indexPath) as? ItemCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let characters = characters {
            let character = characters[indexPath.row]
            let viewModel = CollectionViewCellViewModel(name: character.name, image: character.image)
            cell.configure(with: viewModel)
            return cell
        } else {
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.alpha = 0.7
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                UIView.animate(withDuration: 0.2) {
                    cell.contentView.alpha = 1.0
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter  else { return UICollectionReusableView() }
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewFooterButtons.identifier, for: indexPath) as! CollectionViewFooterButtons
        
        footerView.delegate = self
        
        if let numberOfPages {
            if page == 1 {
                footerView.config(hidden: (next: false, previous: true))
            } else if page == numberOfPages{
                footerView.config(hidden: (next: true, previous: false))
            } else {
                footerView.config(hidden: (next: false, previous: false))
            }
        }
        
        return footerView
        
    }
    
}

//MARK: Delegate Methods
extension CharactersViewController: CollectionViewFooterButtonsDelegate {
    
    func previousTapped(_ footer: CollectionViewFooterButtons) {
        page -= 1
        fetchCharacters()
    }
    
    func nextTapped(_ footer: CollectionViewFooterButtons) {
        page += 1
        fetchCharacters()
    }
}
