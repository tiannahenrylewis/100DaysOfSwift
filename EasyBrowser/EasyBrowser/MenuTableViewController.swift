//
//  MenuTableViewController.swift
//  EasyBrowser
//
//  Created by Tianna Henry-Lewis on 2019-03-12.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    //MARK: - Variables
    var websites = ["hackingwithswift.com", "raywenderlich.com", "apple.com"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Websites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteURL", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    
    //MARK: - didSelectRowAt
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
            vc.selectedWebsite = websites[indexPath.row]
            vc.websiteList = websites
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
