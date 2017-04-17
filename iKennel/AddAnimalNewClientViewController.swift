//
//  AddAnimalNewClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 4/4/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class AddAnimalNewClientViewController: UIViewController {

    @IBOutlet weak var animalName: UITextField!
    @IBOutlet weak var animalType: UISegmentedControl!
    @IBOutlet weak var animalBreed: UITextField!
    @IBOutlet weak var animalSex: UISegmentedControl!
    @IBOutlet weak var animalNotes: UITextField!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateTag = 0
    
    let bannedChars = CharacterSet(charactersIn: "0123456789./*+!@#$%^&*()_=`~;:'\"[]{}|,<>?")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
        
        if animalName.text == "" {
            doneButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelDatePicker(segue:UIStoryboardSegue) { }
    
    @IBAction func addDatePicker(segue:UIStoryboardSegue) {
        dateInButton.setTitle(dateIn_string, for: .normal)
        dateOutButton.setTitle(dateOut_string, for: .normal)
    }
    
    @IBAction func dateButtonPressed(_ sender: UIButton) {
        dateTag = sender.tag
        performSegue(withIdentifier: "pickDate", sender: sender)
    }
    
    func createAnimal() -> Animal {
        return Animal(name: animalName.text!, type: animalType.titleForSegment(at: animalType.selectedSegmentIndex)!, sex: animalSex.titleForSegment(at: animalSex.selectedSegmentIndex)!, breed: animalBreed.text!, social: socialSwitch.isOn, reservation: Reservation(dateIn: dateIn, dateOut: dateOut, checkedIn: checkedInSwitch.isOn), notes: animalNotes.text!)
    }
    
    @IBAction func checkField(_ sender: UITextField) {
        if sender.text != "" {
            if ((sender.text?.rangeOfCharacter(from: bannedChars)) != nil) {
                errorLabel.text = "Numbers or symbols not allowed in field"
                sender.textColor = UIColor.red
                doneButton.isEnabled = false
            } else {
                sender.textColor = UIColor.black
                errorLabel.text = ""
                doneButton.isEnabled = true
            }
        } else {
            errorLabel.text = "Field required"
            sender.textColor = UIColor.red
            doneButton.isEnabled = false
        }
        
    }
    
    func checkDates() {
        if dateIn >= dateOut {
            errorLabel.text = "The 'Date in' can not be after the 'Date out'"
            doneButton.isEnabled = false
        } else {
            errorLabel.text = ""
            doneButton.isEnabled = true
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "pickDate":
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.dateTag = dateTag
        case "unwindSaveToNewClient":
            let newClientVC = segue.destination as! NewClientViewController
            newClientVC.newAnimal = createAnimal()
        case "unwindToNewClient": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }

}
