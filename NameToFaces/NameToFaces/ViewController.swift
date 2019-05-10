//
//  ViewController.swift
//  NameToFaces
//
//  Created by Tianna Henry-Lewis on 2019-05-06.
//  Copyright © 2019 Tianna Henry-Lewis. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //Stores all of the new people we can add
    var people = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //Add a button to allow the user to add a new person (image)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
    }

    //MARK: - Collection View Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            fatalError("Unable to dequeue a PersonCell.")
        }

        //putt out hte person from the popeple array at the correct position
        let person = people[indexPath.item]

        //set the name label to the persons name
        cell.name.text = person.name

        //createa UIImage from the persons image filename, adding it to the value from getDocumentsDirectory() so that we have a full for the image
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)

        //customize border styles using CALayer - add a border, round corners of the image and cell
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 5
        cell.layer.cornerRadius = 7

        return cell
    }

    @objc func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

        //convert image to JPEG data
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            //if we have valid JPEG data, write to disk
            try? jpegData.write(to: imagePath)
        }

        //create a person instance, passing in the name and the image
        let person = Person(name: "Unknown", image: imageName)
        //add the newly created person to the people array
        people.append(person)
        //reload the collectionView so the changes made can be seen immediately
        collectionView.reloadData()

        dismiss(animated: true)

    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let person = people[indexPath.item]
        print(person)

        let ac = UIAlertController(title: "Rename or Delete?", message: "Would you like to rename or delete the person you selected.", preferredStyle: .alert)

        // Create "Delete" button and present to user, perform action if user selects
        ac.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self, weak ac] _ in
            let deleteAlert = UIAlertController(title: "Delete", message: "Confirm you would like to delete the selected person.", preferredStyle: .alert)
            //Confirm No - Cancel action
            deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .default) { [weak self, weak deleteAlert] _ in
                return
            })
            //Confirm Yes - proceed with delete action
            deleteAlert.addAction(UIAlertAction(title: "Delete", style: .destructive) { [weak self, weak deleteAlert] _ in
                self!.people.remove(at: Int(indexPath.item))
                self?.collectionView.reloadData()
            })

            self!.present(deleteAlert, animated: true)
        })

        // Create "Rename" button and present to user, perform action if user selects
        ac.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak ac] _ in
            let renameAlert = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)

            renameAlert.addTextField()

            renameAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive))

            renameAlert.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak renameAlert] _ in
                //print("Rename function entered")
                guard let newName = renameAlert?.textFields?[0].text else { return }
                person.name = newName
                self?.collectionView.reloadData()
            })



            self!.present(renameAlert, animated: true)
        })

        present(ac, animated: true)
    }

    @objc func renamePerson() {
        //        let renameAlert = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .alert)
        //
        //        renameAlert.addTextField()
        //
        //        renameAlert.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self, weak ac] _ in
        //            guard let newName = ac?.textFields?[0].text else { return }
        //            person.name = newName
        //            self?.collectionView.reloadData()
        //        })
        //
        //        renameAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        //
        //        present(renameAlert, animated: true)
        print("You have selected to rename.")
    }

}

