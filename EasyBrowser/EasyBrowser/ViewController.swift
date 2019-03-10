//
//  ViewController.swift
//  EasyBrowser
//
//  Created by nix.codes on 2019-03-09.
//  Copyright © 2019 nix.codes. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    //MARK: - Variables
    var webview: WKWebView!
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        let url = URL(string: "https://www.fcbarcelona.com/en")!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func openTapped() {
        //Instantiate an action sheet alert controller
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        //Alert Controller Actions - web pages user can visit
        ac.addAction(UIAlertAction(title: "manutd.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "nhl.com/mapleleafs", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "nba.com/raptors/?splash=off", style: .default, handler: openPage))
        
        //Alert Controller Actions - Cancel - close alert controller
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        //Included for use on iPads
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        //Present the alert controller to the user
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://www." + actionTitle) else { return }
        webview.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }


}

