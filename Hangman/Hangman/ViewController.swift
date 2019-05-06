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
    var guessedLetters = [String]()
    var currentAnswer = ""
    var currentScore = 0 {
        didSet {
            scoreLabel.text = "Score: \(currentScore)"
        }
    }
    var livesRemaining = 7 {
        didSet {
            lifeLabel.text = "Lives Remaining: \(livesRemaining)/7"
        }
    }
    var puzzleCount = 0
    var letterBits = [String]()
    var alphabet = [String]()
    
    var scoreLabel: UILabel!
    var lifeLabel: UILabel!
    var imageView = UIImageView()
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

        let resetButton = UIButton(type: .system)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        resetButton.setTitle("RESET", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor.orange
        resetButton.layer.cornerRadius = 24
        view.addSubview(resetButton)

        imageView.image = UIImage(named: "hangman0.png")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
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
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 50),
            //WORD TO GUESS LABEL
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: buttonsView.topAnchor, constant: -25),
            //BUTTONS VIEW
            buttonsView.widthAnchor.constraint(equalToConstant: 378),
            buttonsView.heightAnchor.constraint(equalToConstant: 300),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25),
            //RESET BUTTON
            resetButton.widthAnchor.constraint(equalToConstant: 105),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -40),
            resetButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
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
        print("guessedLetters: \(guessedLetters)")
        
    }
    
    //MARK: - loadLevel()
    func loadLevel() {
        wordToGuess = ""
        //remove any items from the usedLetters Array
        usedLetters.removeAll()
        guessedLetters.removeAll()

        //set the image to "hangman0.png"
        imageView.image = UIImage(named: "hangman0.png")

        //Set lives to 7
        if currentScore == 0 {
            livesRemaining = 7
        }
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
        //set the button letter to the character displayed on the button
        guard let buttonLetter = sender.titleLabel?.text else { return }
        print(sender.titleLabel?.text)
        guessedLetters += [buttonLetter]
        print("guessedLetters: \(guessedLetters)")

        wordToGuess = ""

        //TO DO: - Check if the letter that was tapped is in the wordToGuess
        for letter in word {
            let strLetter = String(letter)

            if guessedLetters.contains(strLetter) {
                wordToGuess += strLetter
            } else {
                wordToGuess += "?"
            }
        }

        if usedLetters.contains(buttonLetter) {
            currentScore += 1
        } else {
            livesRemaining -= 1
        }

        //add the button to the array of pressed buttons
        activatedButtons.append(sender)
        
        //hide the button from view
        sender.isHidden = true

        checkGame()
    }
    
    @objc func resetTapped(_ sender: UIButton) {

    }

    func checkGame() {
        switch livesRemaining {
        case 7:
            imageView.image = UIImage(named: "hangman0.png")
        case 6:
            imageView.image = UIImage(named: "hangman1.png")
        case 5:
            imageView.image = UIImage(named: "hangman2.png")
        case 4:
            imageView.image = UIImage(named: "hangman3.png")
        case 3:
            imageView.image = UIImage(named: "hangman4.png")
        case 2:
            imageView.image = UIImage(named: "hangman5.png")
        case 1:
            imageView.image = UIImage(named: "hangman6.png")
        case 0:
            imageView.image = UIImage(named: "hangman7.png")
        default:
            imageView.image = UIImage(named: "hangman0.png")
        }

        if livesRemaining == 0 {
            let ac = UIAlertController(title: "GAME OVER", message: "You have run out of lives.\n Total puzzles solved: \(puzzleCount)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Reset Game", style: .default, handler: callReset))
            present(ac, animated: true)
        }

        if wordToGuess == word {
            let ac = UIAlertController(title: "YOU GOT IT!", message: "You figured it out before it was too late.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Next Puzzle", style: .default, handler: nextLevel))
            present(ac, animated: true)
        }

    }

    func resetButtons() {
        //unhide all of the buttons that were tapped
        for button in activatedButtons {
            button.isHidden = false
        }
        //clear the activatedButtons array
        activatedButtons.removeAll()
    }


    func callReset(action: UIAlertAction) {
        resetButtons()
        livesRemaining = 7
        currentScore = 0
        puzzleCount = 0
        loadLevel()
    }

    func nextLevel(action: UIAlertAction) {
        resetButtons()
        loadLevel()
        puzzleCount += 1
    }
    
    
    
    
    
}






