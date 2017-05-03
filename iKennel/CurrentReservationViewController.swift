//
//  CurrentReservationViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class CurrentReservationViewController: UIViewController {
    
    var cur_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")

    @IBOutlet weak var animalnameLabel: UILabel!
    @IBOutlet weak var animalDateInLabel: UILabel!
    @IBOutlet weak var animalDateOutLabel: UILabel!
    @IBOutlet weak var animalCheckedInLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalnameLabel.text = cur_animal.name
        animalDateInLabel.text = cur_animal.getDMY_time(d: cur_animal.getReservation().dateIn)
        animalDateOutLabel.text = cur_animal.getDMY_time(d: cur_animal.getReservation().dateOut)
        animalCheckedInLabel.text = cur_animal.checkedInToText()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animalnameLabel.text = cur_animal.name
        animalDateInLabel.text = cur_animal.getDMY_time(d: cur_animal.getReservation().dateIn)
        animalDateOutLabel.text = cur_animal.getDMY_time(d: cur_animal.getReservation().dateOut)
        animalCheckedInLabel.text = cur_animal.checkedInToText()
        print(cur_animal.getReservation().checkedIn)
    }
    
    @IBAction func edittingCurrentReservation(segue:UIStoryboardSegue) { }
    
    @IBAction func cancelEdittingCurrentReservation(segue: UIStoryboardSegue) { }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "edittingCurrentReserv":
            guard let editCurrentReservVC = segue.destination as? EditReservationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            editCurrentReservVC.current_animal = cur_animal
        case "saveEditReservation":
            guard let reservationTableVC = segue.destination as? ReservationTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            reservationTableVC.editReservation = cur_animal
        case "cancelEditReserv": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
    

}
