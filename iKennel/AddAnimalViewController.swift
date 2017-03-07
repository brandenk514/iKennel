//
//  AddAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class AddAnimalViewController: UIViewController {

    @IBOutlet weak var animalName: UITextField!
    @IBOutlet weak var animalType: UISegmentedControl!
    @IBOutlet weak var animalBreed: UITextField!
    @IBOutlet weak var animalSex: UISegmentedControl!
    @IBOutlet weak var animalNotes: UITextField!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateTag = 0

    var animalTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pickDate" {
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.dateTag = dateTag
        } else {
            let newClientVC = segue.destination as! NewClientViewController
            newClientVC.name = animalName.text!
            newClientVC.type = animalType.titleForSegment(at: animalType.selectedSegmentIndex)!
            newClientVC.breed = animalBreed.text!
            newClientVC.sex = animalSex.titleForSegment(at: animalSex.selectedSegmentIndex)!
            newClientVC.notes = animalNotes.text!
            newClientVC.social = socialSwitch.isOn
            newClientVC.dateIn = dateIn
            newClientVC.dateOut = dateOut
            newClientVC.checkedIn = checkedInSwitch.isOn
        }
    }
 
}
