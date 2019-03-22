//
//  ViewController.swift
//  Petitions
//
//  Created by Tianna Henry-Lewis on 2019-03-19.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var urlString = ""
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Create a right bar button item that presents an alert telling the user where the data was sourced from
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(showCredits))
        
        //Create 2 UIBarButtonItems, one to search and one to refresh the list and add it to the set of LeftBarButtonItems
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(promptForTerm))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshList))
        self.navigationItem.setLeftBarButtonItems([search, refresh], animated: false)
        
    
        //Depending on the tab that is selected from the Tab Bar, change which data is loaded
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try?Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        //var filteredPetitions = petitions
        
        showAlert(alertTitle: "Loading Error", alertMessage: "There was a problem loading the feed; please check your connection and try again.")
    }

    
    //MARK: - Table View Data Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filteredPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - parse(json: Data) Method
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try?decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            filteredPetitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    //MARK: - showError()
    func showAlert(alertTitle: String, alertMessage: String) {
        let ac = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    //MARK: - showCredits()
    @objc func showCredits() {
        showAlert(alertTitle: "Credits \n", alertMessage: "Data has been sourced \n from the We The People API \n provided by The White House")
    }
    
    //MAKR: - promptForTerm() {
    @objc func promptForTerm() {
        //Instantiate Alert Controller
        let ac = UIAlertController(title: "Search Petitions", message: "Enter a search term to filter petitions results.", preferredStyle: .alert)
        //Add a text field the alert, so user can enter a string
        ac.addTextField()

        //Create the submit action
        let submitTerm = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let term = ac?.textFields?[0].text else { return }
            self?.submit(term)
        }

        //Add submitTerm to the alert
        ac.addAction(submitTerm)
        //present the alert
        present(ac, animated: true)
    }

    //MARK: - submit(term: String)
    func submit(_ term: String) {
        
        filteredPetitions.removeAll()
        
        for item in petitions {
            if item.title.contains(term) || item.body.contains(term) {
                filteredPetitions.append(item)
            }
        }
        
        if filteredPetitions.count == 0 {
            showAlert(alertTitle: "No Results", alertMessage: "Could not find any petitions containing the word \(term)")
            refreshList()
        }
        
        tableView.reloadData()
    }
    
    @objc func refreshList() {
        for item in petitions {
            filteredPetitions.append(item)
        }
        tableView.reloadData()
    }

}






