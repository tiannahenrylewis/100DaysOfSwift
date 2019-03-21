//
//  ViewController.swift
//  AutoLayout
//
//  Created by Tianna Henry-Lewis on 2019-03-16.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labelSpacing: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create 5 labels
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .cyan
        label1.text = "@NIX.CODES"
        label1.textAlignment = .center
        label1.sizeToFit()
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .lightGray
        label2.text = "IS"
        label2.textAlignment = .center
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .cyan
        label3.text = "LEARNING"
        label3.textAlignment = .center
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .lightGray
        label4.text = "AUTO"
        label4.textAlignment = .center
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .cyan
        label5.text = "LAYOUT"
        label5.textAlignment = .center
        label5.sizeToFit()
        
        //Add labels 1-5 to the view (viewController canvas)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        
//        //Create a dictionary of the labels to be used
//        let viewsDictionary = ["label1" : label1, "label2" : label2, "label3" : label3, "label4" : label4, "label5" : label5]
//
//        //Create a dictionary to hold the metrics to be used in VFL
//        let metrics = ["labelHeight" : 88]
//
//        //Horizontal
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        //Vertical
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
        
        var previous: UILabel?
        
        for label in [label1, label2, label3, label4, label5] {
            
            //label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            
            //Use of leadingAnchor and trailingAnchor contraints to replace the widthAnchor constraint used above
//                label.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//                label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
            //Applying safeAreaLayoutGuide to the leading and trailing Anchor constraints
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

            
            //heightAnchor constraints
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2, constant: -10).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
            
        }
    }
}

