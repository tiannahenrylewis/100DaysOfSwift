//
//  ViewController.swift
//  WordScramble
//
//  Created by Tianna Henry-Lewis on 2019-03-12.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Add a rightBarButtonItem to the Navigation Controller that presents a UIAlert that allows the user to enter an answer
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        //Add a leftBarButtonItem to the Navigation Controller that calls startGame() so users can restart with a new word
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        
        //Load words from start.txt into the allWords array
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                    allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    //MARK: - startGame()
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    //MARK: - Tableview Data Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    //MARK: - promptForAnswer()
    @objc func promptForAnswer() {
        //Set-up alert controller for use
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        //Add a text field for user input
        ac.addTextField()
        
        //Create the submit action (submitAction)
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    //MARK: - submit()
    func submit (_ answer: String) {
        
        let lowerAnswer = answer.lowercased()
        
        //Run the users submitted word through a series of checks (is it possible with the letters available, has not been previously submitted, and is it a real word
        if isStartWord(word: lowerAnswer) {
            if isPossible(word: lowerAnswer) {
                if isOriginal(word: lowerAnswer) {
                    if isReal(word: lowerAnswer) {
                        //If all checks are passed add the users word to the usedWords array and add it to the 0th position of the tableview (top of table)
                        usedWords.insert(lowerAnswer, at: 0)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    } else {
                        showErrorMessage(errorTitle: "Word not recognized", errorMessage: "It has to be a real word and 3 letters or longer to count")
                    }
                } else {
                    showErrorMessage(errorTitle: "Already Submitted", errorMessage: "You can't submit the same word twice")
                }
            } else {
                guard let title = title?.lowercased() else { return }
                showErrorMessage(errorTitle: "Word Not Possible", errorMessage: "You can't spell \(answer) from the word \(title)")
            }
        } else {
            showErrorMessage(errorTitle: "Too Easy", errorMessage: "Using the title word does not count.")
        }
    }
    
    //MARK: - isStartWord() {
    func isStartWord(word: String) -> Bool {
        if word != title {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - isPossible()
    func isPossible(word: String) -> Bool {
        
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        
          return true
    }
    
    //MARK: - isOriginal()
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    //MARK: - isReal()
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location == NSNotFound && word.utf16.count >= 3 {
            return true
        } else {
            return false
        }
    }
    
    //MARK: - showErrorMessage()
    func showErrorMessage(errorTitle: String, errorMessage: String) {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

}

