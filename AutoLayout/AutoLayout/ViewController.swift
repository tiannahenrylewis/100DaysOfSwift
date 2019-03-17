//
//  ViewController.swift
//  AutoLayout
//
//  Created by Tianna Henry-Lewis on 2019-03-16.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create 5 labels
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .purple
        label1.text = "@nix.codes"
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .lightGray
        label2.text = "is"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .purple
        label3.text = "learning"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .lightGray
        label4.text = "Auto"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .purple
        label5.text = "Layout"
        label5.sizeToFit()
        
        //Add labels 1-5 to the view (viewController canvas)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
        //Create a dictionary of the labels
        let viewsDictionary = ["label1" : label1, "label2" : label2, "label3" : label3, "label4" : label4, "label5" : label5]
        
        //Horizontal
        for label in viewsDictionary.keys {
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
        }
        
        //Vertical
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))

    }
}

