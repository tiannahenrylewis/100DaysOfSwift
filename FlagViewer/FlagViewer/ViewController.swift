//
//  ViewController.swift
//  FlagViewer
//
//  Created by Tianna Henry-Lewis on 2019-03-08.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //MARK: - Variables
    var flags = [String]()

    //MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set the title of the navigation controller and change to Large Title style
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //Load Images from Disk
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let flagItems = try! fm.contentsOfDirectory(atPath: path)
    
        //Loop through the items found and if the item is a png file add it to the flags array
        for item in flagItems {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
        flags.sort()
    }
    
    //MARK: - TableView Setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        cell.textLabel?.text = String(flags[indexPath.row]).uppercased()
        cell.imageView!.image = UIImage(named: flags[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedFlag = flags[indexPath.row]
            vc.totalFlagCount = flags.count
            vc.currentFlagNumber = indexPath.row + 1
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    
}
