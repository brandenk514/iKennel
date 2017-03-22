//
//  EditAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/7/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditAnimalViewController: UIViewController {

    var sel_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeSelector: UISegmentedControl!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var sexSelector: UISegmentedControl!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var notesField: UITextField!
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.text = sel_animal.name
        if nameField.text!.isEmpty { nameField.placeholder = "Name" }
        typeSelector.selectedSegmentIndex = sel_animal.setTypeSelectorIndex()
        breedField.text = sel_animal.breed
        if breedField.text!.isEmpty { breedField.placeholder = "Breed" }
        sexSelector.selectedSegmentIndex = sel_animal.setSexSelectorIndex()
        socialSwitch.isOn = sel_animal.social
        notesField.text = sel_animal.notes
        if notesField.text!.isEmpty { notesField.placeholder = "Notes" }
        dateInButton.setTitle(sel_animal.getDMY_time(d: sel_animal.getReservation().dateIn), for: .normal)
        dateOutButton.setTitle(sel_animal.getDMY_time(d: sel_animal.getReservation().dateOut), for: .normal)
        checkedInSwitch.isOn = sel_animal.getReservation().checkedIn

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
