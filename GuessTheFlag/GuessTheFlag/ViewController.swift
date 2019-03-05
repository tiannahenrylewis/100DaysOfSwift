//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Tianna Henry-Lewis on 2019-03-04.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IB Connections
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    // MARK: - Variables
    var countries = [String]()
    var score = 0

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add line border to buttons
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        //Customize the colour of the line border around the buttons
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        //Load countries away with the flags we have
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us"]
        
        askQuestion()
    }
    
    func askQuestion() {
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }


}

