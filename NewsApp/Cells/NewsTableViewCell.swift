//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Dilshodi Kahori on 6/19/22.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    lazy var imageContainerView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(imageContainerView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
    }
    
    func makeConstraints() {
        let constraints: [NSLayoutConstraint] = [
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageContainerView.leadingAnchor.constraint(equalTo: contentLabel.trailingAnchor, constant: 10),
            imageContainerView.widthAnchor.constraint(equalToConstant: 120),
            imageContainerView.heightAnchor.constraint(equalToConstant: 140),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: -10),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.widthAnchor.constraint(equalToConstant: 250),
            contentLabel.heightAnchor.constraint(equalToConstant: 80),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
