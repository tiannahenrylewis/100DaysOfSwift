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
    var levelLabel: UILabel!
    var letterButtons = [UIButton]()
    
    let buttonHeight: CGFloat = 44
    let buttonWidth: CGFloat = 88
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var level = 1 {
        didSet {
            levelLabel.text = "Level: \(level)"
        }
    }
    
    var matchedItemsCount = 0
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: \(score)"
        view.addSubview(scoreLabel)
        
        levelLabel = UILabel()
        levelLabel.translatesAutoresizingMaskIntoConstraints = false
        levelLabel.textAlignment = .left
        levelLabel.text = "Level: \(level)"
        view.addSubview(levelLabel)
        
        
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
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            levelLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            levelLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor, constant: -20),
            
            
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
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                let frame = CGRect(x: column * letterButtonWidth,
                                   y: row * letterButtonHeight,
                                   width: letterButtonWidth,
                                   height: letterButtonHeight)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
        
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.gray.cgColor
        
        //MARK: - Testing Code [Not For Production]
        //For visualizing and testing purposes
//        scoreLabel.backgroundColor = .yellow
//        cluesLabel.backgroundColor = .yellow
//        answersLabel.backgroundColor = .cyan
//        currentAnswer.backgroundColor = .cyan
//        submit.backgroundColor = .orange
//        clear.backgroundColor = .orange
//        buttonsView.backgroundColor = .yellow
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadLevel()
    }
    
    @objc func letterTapped (_ sender: UIButton) {
        //set the button title to the text displayed on the button
        guard let buttonTitle = sender.titleLabel?.text else { return }
        
        //add the button letters to the current answer
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        
        //Add the button to the array of pressed buttons
        activatedButtons.append(sender)
        
        //Hide the button from view
        sender.isHidden = true
    }
    
    @objc func submitTapped (_ sender: UIButton) {
        //read answerText from answer text field
        guard let answerText = currentAnswer.text else { return }
        
        print("answerText: \(answerText)")
        print("solutions: \(solutions)")
        
        if let solutionPosition = solutions.firstIndex(of: answerText) {
            //empty tapped buttons from activatedButtons array
            activatedButtons.removeAll()
            
            var splitAnswers = answersLabel.text?.components(separatedBy: "\n")
            
            splitAnswers?[solutionPosition] = answerText
            
            answersLabel.text = splitAnswers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            matchedItemsCount += 1
            score += 1
            
            if matchedItemsCount == 7 {
                let ac = UIAlertController(title: "Level Complete!", message: "You have solved all of the missing words.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Next Level", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            
            score -= 1
            
            let ac = UIAlertController(title: "Wrong!", message: "\(answerText) is not one of the hidden words.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Guess Again", style: .default))
                present(ac, animated: true)
        }
    }
    
    @objc func clearTapped (_ sender: UIButton) {
        //set the currentAnswer back to an empty string
        currentAnswer.text = ""
        
        //unhide all of the buttons that were tapped
        for button in activatedButtons {
            button.isHidden = false
        }
        
        //clear the activatedButtons array
        activatedButtons.removeAll()
    }
    
    func loadLevel() {
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") {
            
            if let levelContents = try? String(contentsOf: levelFileURL) {
                
                var lines = levelContents.components(separatedBy: "\n")
                lines.shuffle()
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts [1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutionString += "\(solutionWord.count) letters\n"
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    
                    letterBits += bits
                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }
        
    }
    
    func levelUp(action: UIAlertAction) {
        //increment level value to 1
        level += 1
        
        //remove all items from the solutions array
        solutions.removeAll(keepingCapacity: true)
        
        //call loadLevel()
        loadLevel()
        
        //make sure all letter buttons are visible once again
        for button in letterButtons {
            button.isHidden = false
        }
    }


    
    
    
}

