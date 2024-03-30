//
//  HomeView.swift
//  Architecture-MVVM
//
//  Created by Nahuel Lalin on 30/03/2024.
//

import Foundation
import UIKit

class HomeView: UIViewController {
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 30, weight: .bold, width: .standard)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
        ])
    }
}
