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
    var progressView: UIProgressView!
    var websites = ["laliga.es", "nhl.com", "nba.com"]
    
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(WKWebView.reload))
        
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.isToolbarHidden = false
        
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + websites[0])!
        webview.load(URLRequest(url: url))
        webview.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func openTapped() {
        //Instantiate an action sheet alert controller
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        //Alert Controller Actions - web pages user can visit
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        let url = navigationAction.request.url
        
            if let host = url?.host {
                for website in websites {
                    if host.contains(website) {
                        decisionHandler(.allow)
                        return
                    }
                }
            }
        
        decisionHandler(.cancel)
    }
    
    
    
}

