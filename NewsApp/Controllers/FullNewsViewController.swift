//
//  FullNewsViewController.swift
//  NewsApp
//
//  Created by Dilshodi Kahori on 6/19/22.
//

import UIKit
import WebKit

class FullNewsViewController: UIViewController {

    let webView = WKWebView()
    var receivingURL = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.load(URLRequest(url: receivingURL!))
        setUpView()
    }
    
    private func setUpView() {
        view.addSubview(webView)
        webView.frame = view.bounds
    }
    
    private func makeConstraints() {
        let constraints: [NSLayoutConstraint] = [
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
