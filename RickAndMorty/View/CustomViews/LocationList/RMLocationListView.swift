//
//  RMLocationListView.swift
//  RickAndMorty
//
//  Created by Arda Büyükhatipoğlu on 5.03.2024.
//

import UIKit

class RMLocationListView: UIView {
    
    //MARK: Components
    private var tableView: UITableView!
    private let loadingSpinner = RMLoadingSpinnerView()
    
    //MARK: Properties
    private var viewModel: RMLocationListVM? {
        didSet {
            loadingSpinner.stopLoadingAnimation()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureTableViewAndLoadingSpinner()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureTableViewAndLoadingSpinner() {
        tableView = UITableView(frame: .zero)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(RMLocationCell.self, forCellReuseIdentifier: RMLocationCell.identifier)
        
        addSubviews(tableView, loadingSpinner)
        tableView.pinToEdges(of: self)
        loadingSpinner.pinToEdges(of: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.alpha = 0
        tableView.isHidden = true
        loadingSpinner.startLoadingAnimation()
    }
    
    
    func configure(with viewModel: RMLocationListVM) {
        self.viewModel = viewModel
    }
}

extension RMLocationListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Notify Controller of selection
    }
}


extension RMLocationListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.cellViewModels[indexPath.row] else { fatalError() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RMLocationCell.identifier, for: indexPath) as? RMLocationCell else { return UITableViewCell() }
        cell.textLabel?.text = cellViewModel.name
        return cell
    }
    
    
}
