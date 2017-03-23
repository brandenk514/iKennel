//
//  EditReservationViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/27/17.
//  Copyright © 2017 BK Development. All rights reservevar//

import UIKit

class EditReservationViewController: UIViewController {
    
     var current_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var dateTag = 0
    var dateIn = Date()
    var dateOut = Date()
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"

    @IBOutlet weak var animal_nameLabel: UILabel!
    @IBOutlet weak var animal_DateIn: UIButton!
    @IBOutlet weak var animal_DateOut: UIButton!
    @IBOutlet weak var animal_checkedIn: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateIn_string = current_animal.getDMY_time(d: current_animal.getReservation().dateIn)
        dateOut_string = current_animal.getDMY_time(d: current_animal.getReservation().dateOut)
        
        animal_nameLabel.text = current_animal.name
        animal_DateIn.setTitle(dateIn_string, for: .normal)
        animal_DateOut.setTitle(dateOut_string, for: .normal)
        animal_checkedIn.isOn = current_animal.getReservation().checkedIn

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewDate(_ sender: UIButton) {
        dateTag = sender.tag
        performSegue(withIdentifier: "reservDatePicker", sender: sender)
        if dateIn != current_animal.getReservation().dateIn { // Conditions are wrong need to fixed
            current_animal.reservation?.dateIn = dateIn
        }
        if dateOut != current_animal.getReservation().dateOut {
            current_animal.reservation?.dateOut = dateOut
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelEditReservDate(segue:UIStoryboardSegue) { }
    
    @IBAction func saveEditReservDate(segue:UIStoryboardSegue) {
        animal_DateIn.setTitle(dateIn_string, for: .normal)
        animal_DateOut.setTitle(dateOut_string, for: .normal)
    }

    @IBAction func didCheckInChange(_ sender: UISwitch) {
        current_animal.reservation?.checkedIn = sender.isOn
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "reservDatePicker" {
            let datePickerVC = segue.destination as! ReservDatePickerViewController
            datePickerVC.dateTag = dateTag
        } else {
            let currentReservVC = segue.destination as! CurrentReservationViewController
            currentReservVC.cur_animal = current_animal
            print(current_animal)
        }
    }
    

}
