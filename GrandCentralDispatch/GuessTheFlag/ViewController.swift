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
    @IBOutlet weak var countryLabel: UIBarButtonItem!
    
    // MARK: - Variables
    var countries = [String]()
    var score = 0
    var currentScore = 0
    var correctAnswer = 0
    var questionsAsked = 0

    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add Right Bar Button Item to Navigation Controller
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Check Score", style: .plain, target: self, action: #selector(checkScore))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        
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
        
        //Call ask Question on load
        askQuestion(action: nil)
    }
    
    func askQuestion(action: UIAlertAction!) {
        //Add one to the number of questions asked variable
        questionsAsked += 1
        
        //Shuffle the array so that you are presented with 3 flags at random
        countries.shuffle()
        
        //Set the correct answer to one of the three randomly selected flags
        correctAnswer = Int.random(in: 0...2)
        
        //Uppercase the entire string using a built-in swift method
        countryLabel.title = countries[correctAnswer].uppercased()
        
        //Set the button images to the first 3 images of the shuffled array
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        /*
            buttonTapped needs to do 3 things:
            1. Check whether the answer was correct
            2. Adjust the players score
            3. Show a message telling the player what their new score is
        */
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        if questionsAsked == 10 {
            let finalAC = UIAlertController(title: "Game Over", message: "Final Score: \(score)/10", preferredStyle: .alert)
            finalAC.addAction(UIAlertAction(title: "Try Again", style: .default, handler: askQuestion))
            present(finalAC, animated: true)
            
            //Reset question counter and score to 0
            questionsAsked = 0
            score = 0
            print("Game Reset")
        } else {
            switch title {
            case "Correct":
                let ac = UIAlertController(title: title, message: "Score: \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            case "Wrong":
                let ac = UIAlertController(title: title, message: "That's the flag for \(countries[sender.tag].uppercased()) \n Score: \(score)", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
                present(ac, animated: true)
            default:
                print("Error")
            }
        }
        
    }
    
    func setScore(action: UIAlertAction!) {
        currentScore = score
    }
    
    @objc func checkScore() {
        let scoreAlert = UIAlertController(title: "Current Score", message: "Score: \(score)", preferredStyle: .alert)
        scoreAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: setScore))
        present(scoreAlert, animated: true)
    }
    
        
}
    



