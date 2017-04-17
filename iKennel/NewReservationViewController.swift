//
//  NewReservationViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 4/10/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewReservationViewController: UIViewController, UIPickerViewDelegate {
    
    var animalList = [Animal]()
    var clientList = [Contact]()
    
    var selectedClient = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    var selectedAnimal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    @IBOutlet weak var animalPicker: UIPickerView!
    @IBOutlet weak var selectClientButton: UIButton!
    @IBOutlet weak var dateInPicker: UIDatePicker!
    @IBOutlet weak var dateOutPicker: UIDatePicker!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    @IBOutlet weak var dateInLabel: UILabel!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animalPicker.dataSource = self as? UIPickerViewDataSource;
        self.animalPicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedClient.lName != "" {
            selectClientButton.setTitle(selectedClient.lName + ", " + selectedClient.fName, for: .normal)
            errorLabel.text = ""
        } else {
            errorLabel.text = "No client selected"
            saveButton.isEnabled = false
        }
        loadAnimalsFromClient()
        if animalList.count != 0 {
            selectedAnimal = animalList[0]
            saveButton.isEnabled = true
            errorLabel.text = ""
        } else {
            errorLabel.text = "No animal selected"
        }
        animalPicker.reloadAllComponents()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return animalList.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return animalList[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedAnimal = animalList[row]
    }
    
    @IBAction func unwindToNewReserv(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindSaveToNewReserv(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func checkDates(_ sender: UIDatePicker) {
        if dateInPicker.date >= dateOutPicker.date {
            errorLabel.text = "The 'Date in' can not be after the 'Date out'"
            dateInLabel.textColor = UIColor.red
            saveButton.isEnabled = false
        } else {
            errorLabel.text = ""
            dateInLabel.textColor = UIColor.black
            saveButton.isEnabled = true
        }
    }
    
    func loadAnimalsFromClient() {
        animalList = selectedClient.animals!
    }
    
    func newReservation() {
        selectedAnimal.reservation = Reservation(dateIn: dateInPicker.date, dateOut: dateOutPicker.date, checkedIn: checkedInSwitch.isOn)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "addNewReserv":
            guard let reservationTableVC = segue.destination as? ReservationTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            newReservation()
            reservationTableVC.newReservationEntry = selectedAnimal
        case "cancelNewReservation": break
        case "selectClient":
            guard let selectClientVC = segue.destination as? SelectClientViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            selectClientVC.clientList = clientList
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
 

}
