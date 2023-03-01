//
//  ViewController.swift
//  Acrch
//
//  Created by Evhen Lukhtan on 20.02.2023.
//

import UIKit
import SnapKit
import Combine

enum ButtonType {
    case submit
    case pagination
}

class ViewController: UIViewController {
    
    // MARK: - Variables
    var lower: String?
    var upper: String?
    var buttonType: ButtonType?
    
    // MARK: - ViewModel
    private var viewModel: CommentListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    init(lower: String, upper: String) {
        self.viewModel = CommentListViewModel(lower: lower, upper: upper)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifececycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindUI()
        buttonTypeDidTap()
    }
    
    // MARK: - Private Func
    private func buttonTypeDidTap() {
        if let buttonType = buttonType {
            switch buttonType {
            case .submit:
                submitButtonTapped()
                break
            case .pagination:
                viewModel.fetchDataWithPagination(limit: 10)
                break
            }
        }
    }
    
    private func submitButtonTapped() {
        let start1 = Int(lower ?? "") ?? 0
        let end1 = Int(upper ?? "") ?? 0
        viewModel.fetchData()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindUI() {
        viewModel.$comments
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

//MARK: - TableView DataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.comments[indexPath.row].body
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            viewModel.getNComments(limit: 5)
        }
    }
    
}
