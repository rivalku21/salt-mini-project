//
//  HomeController.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import UIKit

class HomeController: UIViewController {
    private let userListViewModel = UserListViewModel()
    
    // MARK: - Variables
    private var users: [UserViewModel] = [
        UserViewModel(user: UserModel(email: "apdkasda@gmail.com", first_name: "aku", last_name: "kamu", avatar: "jbdiasbd.com")),
        UserViewModel(user: UserModel(email: "apdkasda@gmail.com", first_name: "aku", last_name: "kamu", avatar: "jbdiasbd.com")),
        UserViewModel(user: UserModel(email: "apdkasda@gmail.com", first_name: "aku", last_name: "kamu", avatar: "jbdiasbd.com")),
    ]
    
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        return tv
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Loading.."
        label.numberOfLines = 2
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        Task {
            await userListViewModel.getAllData()
            users = userListViewModel.users
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(label)
        self.view.addSubview(tableView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - TableView Functions
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
            fatalError("Unable to dequeue CoinCell in HomeController")
        }
        
        let coin = self.users[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}
