//
//  DetailViewController.swift
//  Petitions
//
//  Created by Tianna Henry-Lewis on 2019-03-20.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style>
                    body {
                        font-size: 150%;
                    }
        
                    h3 {
                        text-align: center;
                    }
                    p {
                        font-size: 20px;
                    }
                </style>
            </head>
            <body>
                <h3>\(detailItem.title)</h3>
                <p>\(detailItem.body)</p>
                <p style="color: blue; text-align:center">Signature Count: \(detailItem.signatureCount)</p>
            </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
        
    }
    


}
