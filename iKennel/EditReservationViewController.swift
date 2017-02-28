//
//  EditReservationViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/27/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

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
        
        animal_nameLabel.text = current_animal.name
        animal_DateIn.setTitle(current_animal.getDMY_time(d: current_animal.getReservation().dateIn), for: .normal)
        animal_DateOut.setTitle(current_animal.getDMY_time(d: current_animal.getReservation().dateOut), for: .normal)
        animal_checkedIn.isOn = current_animal.getReservation().checkedIn

        // Do any additional setup after loading the view.
    }
    @IBAction func addNewDate(_ sender: UIButton) {
        dateTag = sender.tag
        performSegue(withIdentifier: "pickDate", sender: sender)
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
