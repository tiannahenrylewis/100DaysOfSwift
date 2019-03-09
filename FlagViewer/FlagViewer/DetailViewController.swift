//
//  DetailViewController.swift
//  FlagViewer
//
//  Created by Tianna Henry-Lewis on 2019-03-08.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Variables
    var selectedFlag: String?
    var totalFlagCount: Int?
    var currentFlagNumber: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Add Bar Button Item
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = "Flag \(currentFlagNumber!) of \(totalFlagCount!)"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        
        if let imageToLoad = selectedFlag {
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
    
    @objc func shareTapped() {
        
        guard let name = selectedFlag else {
            print("There is no flag.")
            return
        }
        
        guard let flag = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("There is no flag image")
            return
        }
        
        let av = UIActivityViewController(activityItems: [flag, name], applicationActivities: [])
        av.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(av, animated: true)
    }


}
