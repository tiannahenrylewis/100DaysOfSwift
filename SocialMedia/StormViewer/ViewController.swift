//
//  ViewController.swift
//  SocialMedia
//
//  Created by Tianna Henry-Lewis on 2019-03-01.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Variables
    
    var pictures = [String]()

    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //this is a picture to load!
                pictures.append(item)
            }
        }
        
        print(pictures)
        
        //Sort the array of pictures
        pictures.sort()
        
        print(pictures)
    }
    
    //MARK: - TableView Setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        //Use the sorted array from viewDidLoad() to populate the tableview cells
        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        return cell
    }
    
    //MARK: - TableView - Cell Selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 3 things in the line below have the potential to fail, hence the use of an if let statement,
        // if any of the items fail the code within the braces WILL NOT exectue
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.totalPictureCount = pictures.count
            vc.selectedPictureNumber = indexPath.row + 1
            vc.imageName = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }


}

