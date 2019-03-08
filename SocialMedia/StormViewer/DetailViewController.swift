//
//  DetailViewController.swift
//  SocialMedia
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
    var totalPictureCount: Int?
    var selectedPictureNumber: Int?
    var imageName: String?
    
    //MARK: - View Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar Customizations
        title = "Picture \(selectedPictureNumber!) of \(totalPictureCount!)"
        navigationItem.largeTitleDisplayMode = .never
        
        //Adds a bar button item on the left of the navigation item.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

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
    
    //MARK: - shareTapped()
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        guard let name = imageName else {
            print("There is no image name found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image, name], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}
