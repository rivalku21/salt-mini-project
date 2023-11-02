//
//  UserTableViewCell.swift
//  SaltMiniProject
//
//  Created by Rival Fauzi on 02/11/23.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    static let identifier = "UserCell"
    private(set) var user: UserViewModel!
    
    private let avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .black
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with user: UserViewModel) {
        self.user = user
        
        self.username.text = user.firstName + " " + user.lastName
        self.email.text = user.email
        
        let imageData = try? Data(contentsOf: URL(string: self.user.avatar)!)
        
        if let imageData = imageData {
            DispatchQueue.main.async { [weak self] in
                self?.avatar.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(avatar)
        self.addSubview(username)
        self.addSubview(email)
        
        avatar.translatesAutoresizingMaskIntoConstraints = false
        username.translatesAutoresizingMaskIntoConstraints = false
        email.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatar.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            avatar.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            avatar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75),
            
            username.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16),
            username.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            email.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: 16),
            email.centerYAnchor.constraint(equalTo: username.bottomAnchor,  constant: 16),
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
