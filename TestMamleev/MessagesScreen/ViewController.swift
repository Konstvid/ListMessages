//
//  ViewController.swift
//  TestMamleev
//
//  Created by Andrey on 25.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = MessagesViewModel()
    private let dataSource = MessagesDataSource()
    private let spinner = UIActivityIndicatorView(style: .medium)
    private var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    private func configureUI() {
        spinner.color = UIColor.darkGray
        spinner.hidesWhenStopped = true
        
        tableView.tableFooterView = spinner
        tableView.dataSource = dataSource
        tableView.transform = CGAffineTransform(rotationAngle: (-.pi))
    }
    
    private func bind() {
        getMessages(page: counter)
        
        viewModel.errorComletion = { [weak self] error in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.makeAlertController(title: error.localizedDescription)
            }
        }
    }
    
    private func getMessages(page: Int) {
        viewModel.getMessages(page: page) { [weak self] messages in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                guard !messages.isEmpty else { return }
                self?.counter += 1
                self?.dataSource.messages += messages.compactMap { $0 }
                self?.tableView.reloadData()
            }
        }
    }
    
    private func makeAlertController(title: String) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let retryButton = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.getMessages(page: self.counter)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(retryButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if dataSource.messages.count - 2 == indexPath.row {
            spinner.startAnimating()
            getMessages(page: counter)
        }
    }
}
