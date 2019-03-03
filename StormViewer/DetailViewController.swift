//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Tianna Henry-Lewis on 2019-03-02.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - UI Connections
    @IBOutlet var imageView: UIImageView!
    
    //MARK: - Variables
    var selectedImage: String?
    
    //MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Customizations
        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        //selectedImage cannot be used directly as it is an optional, Swift will not let us without
        //checking it first. This is another place to use if let, check if selectedImage has a value
        //and pull out the value otherwise do nothing.
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    

}
