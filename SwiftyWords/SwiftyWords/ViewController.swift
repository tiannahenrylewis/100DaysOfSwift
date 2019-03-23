//
//  ViewController.swift
//  SwiftyWords
//
//  Created by Tianna Henry-Lewis on 2019-03-23.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var currentAnswer: UITextField!
    var scoreLabel: UILabel!
    var letterButtons = [UIButton]()
    
    let buttonHeight: CGFloat = 44
    let buttonWidth: CGFloat = 88
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap Letters to Guess"
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 43)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submit = UIButton(type: .system)
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            //top of cluesLabel pinned to the bottom of scoreLabel
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            //pin leading edge of cluesLabel to leading edge of the screen, indented by 100 points
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            
            //make clueLabel 60% of the width of our layout margins, minus 100
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            //pin top of answersLabel to the bottom of the scoreLabel
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            //make answersLabel stick to the trailing edge of our layout margins, minus 100
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            
            //make answersLabel take up 40% of the available spakce, minus 100
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            
            //make answersLabel match the height of the cluesLabel
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            //center currentAnswers in the view
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //set the width of currentAnswer to 50% of the view
            currentAnswer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.5),
            
            //place currentAnswer below cluesLabel with 20 points of spacing
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            //pin the top of the submit and clear buttons to the bottom of currentAnswer
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            
            //center submit & clear button horizontally in the main view subtracting and adding 100, respectively, so they don't overlap
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            
            //Align the clear button vertically to the submit button
            clear.centerYAnchor.constraint(equalTo: submit.centerYAnchor),
            
            //set the height of the submit and clear buttons to 44
            submit.heightAnchor.constraint(equalToConstant: buttonHeight),
            clear.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            //set the width of the submit and clear buttons to 88
            submit.widthAnchor.constraint(equalToConstant: buttonWidth),
            clear.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            //set the width and height of the buttonsView to 750 x 320
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            
            //Center the buttonsView horizontally
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            //set topAnchor of buttonsView to bottom of the submit button + 20 pts of spacing
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),

            //pin buttonsView to the bottom of the layout margins + 20pt
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20)
            ])
        
        let letterButtonWidth = 150
        let letterButtonHeight = 80
        
        for row in 0..<4 {
            for column in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
                letterButton.setTitle("NIX", for: .normal)
                let frame = CGRect(x: column * letterButtonWidth,
                                   y: row * letterButtonHeight,
                                   width: letterButtonWidth,
                                   height: letterButtonHeight)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        //MARK: - Testing Code [Not For Production]
        //For visualizing and testing purposes
        scoreLabel.backgroundColor = .yellow
        cluesLabel.backgroundColor = .yellow
        answersLabel.backgroundColor = .cyan
        currentAnswer.backgroundColor = .cyan
        submit.backgroundColor = .orange
        clear.backgroundColor = .orange
        buttonsView.backgroundColor = .yellow
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

