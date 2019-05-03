//
//  ViewController.swift
//  Hangman
//
//  Created by Tianna Henry-Lewis on 2019-04-17.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var allWords = [String]()
    var word = ""
    var wordToGuess = "" {
        didSet {
            wordLabel.text = wordToGuess
        }
    }
    var usedLetters = [String]()
    var currentAnswer = ""
    var currentScore = 0
    var livesRemaining = 7 {
        didSet {
            lifeLabel.text = "Lives Remaining: \(livesRemaining)/7"
        }
    }
    var letterBits = [String]()
    var alphabet = [String]()
    
    var scoreLabel: UILabel!
    var lifeLabel: UILabel!
    var hangmanImage: UIImage!
    var wordLabel: UILabel!
    var letterButtons = [UIButton]()
    let buttonHeight = 75
    let buttonWidth = 54
    
    var activatedButtons = [UIButton]()
    

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.backgroundColor = .white
        view.addSubview(buttonsView)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: \(currentScore)"
        scoreLabel.textColor = UIColor.orange
        scoreLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(scoreLabel)
        
        lifeLabel = UILabel()
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeLabel.textAlignment = .left
        lifeLabel.text = "Lives Remaining: \(livesRemaining)/7"
        lifeLabel.textColor = UIColor.orange
        lifeLabel.font = UIFont.systemFont(ofSize: 25)
        view.addSubview(lifeLabel)
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.text = "\(wordToGuess)"
        wordLabel.textColor = UIColor.orange
        wordLabel.font = UIFont.systemFont(ofSize: 40)
        view.addSubview(wordLabel)
        
        
        NSLayoutConstraint.activate([
            //SCORE LABEL
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            //LIVES LABEL
            lifeLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 25),
            lifeLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            //HANGMANIMAGE
            
            //WORD TO GUESS LABEL
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor, constant: -25),
            //BUTTONS VIEW
            buttonsView.widthAnchor.constraint(equalToConstant: 378),
            buttonsView.heightAnchor.constraint(equalToConstant: 300),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25)
            ])
        
        for row in 0..<4 {
            for col in 0..<7 {
                if letterButtons.count < 26 {
                    let letterButton = UIButton(type: .system)
                    letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
                    letterButton.setTitle("T", for: .normal)
                    letterButton.setTitleColor(.orange, for: .normal)
                    let frame = CGRect(x: col * buttonWidth, y: row * buttonHeight, width: buttonWidth, height: buttonHeight)
                    letterButton.frame = frame
                    buttonsView.addSubview(letterButton)
                    letterButtons.append(letterButton)
                    letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        loadLevel()
        
    }
    
    //MARK: - loadLevel()
    func loadLevel() {
        //remove any items from the usedLetters Array
        usedLetters.removeAll()

        //Set lives to 7
        livesRemaining = 7

        //Load Word List
        if let wordsListURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let wordsList = try? String(contentsOf: wordsListURL) {
                allWords = wordsList.components(separatedBy: "\n")
            }
        }

        //Load Alphabet List
        if let alaphabetURL = Bundle.main.url(forResource: "alphabet", withExtension: "txt") {
            if let alphabetList = try? String(contentsOf: alaphabetURL) {
                letterBits = alphabetList.components(separatedBy: "\n")
            }
        }

        //If the wordList.txt was not loaded properly initialize the allWords array mannually.
        if allWords.isEmpty {
            allWords = ["BANANA", "TIANNA", "LEWIS"]
        } else {
            print("Word List loaded successfully!")
        }

        //set the title of the buttons to the letters in the alphabet
        if letterButtons.count == letterBits.count {
            for i in 0..<letterButtons.count {
                letterButtons[i].setTitle(letterBits[i], for: .normal)
            }
        }

        word = allWords.randomElement()!

        for letter in word {
            let strLetter = String(letter)
            usedLetters += [strLetter]
            wordToGuess += "?"
        }

        wordLabel.text = wordToGuess

        print("word: \(word)")
        print("wordToGuess: \(wordToGuess)")
        print("usedLetters: \(usedLetters)")


    }
    
    @objc func letterTapped(_ sender: UIButton) {
        print("1-word: \(word)")
        print("1-wordToGuess: \(wordToGuess)")

        //set the button letter to the character displayed on the button
        guard let buttonLetter = sender.titleLabel?.text else { return }
        print (buttonLetter)


        //TO DO: - Check if the letter that was tapped is in the wordToGuess
        for letter in usedLetters {
            if letter == buttonLetter {
                wordToGuess += buttonLetter
                return
            } else {
                wordToGuess += "?"
            }
        }

        print("2-wordToGuess: \(wordToGuess)")

        //add the button to the array of pressed buttons
        activatedButtons.append(sender)
        
        //hide the button from view
        sender.isHidden = true
    }
    
    @objc func resetTapped(_ sender: UIButton) {
        //unhide all of the buttons that were tapped
        for button in activatedButtons {
            button.isHidden = false
        }
        //clear the activatedButtons array
        activatedButtons.removeAll()
    }
    
    
    
    
    
}






