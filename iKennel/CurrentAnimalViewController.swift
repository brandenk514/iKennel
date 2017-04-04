//
//  CurrentAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/22/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class CurrentAnimalViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var socialLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var dateInLabel: UILabel!
    @IBOutlet weak var dateOutLabel: UILabel!
    @IBOutlet weak var checkedInLabel: UILabel!
    
    var selected_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var current_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    var animalTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selected_animal.name
        typeLabel.text = selected_animal.type
        sexLabel.text = selected_animal.sex
        breedLabel.text = selected_animal.breed
        socialLabel.text = selected_animal.socialToText()
        notesLabel.text = selected_animal.notes
        dateInLabel.text = selected_animal.getDMY_time(d: (selected_animal.reservation?.dateIn)!)
        dateOutLabel.text = selected_animal.getDMY_time(d: (selected_animal.reservation?.dateOut)!)
        checkedInLabel.text = selected_animal.checkedInToText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameLabel.text = selected_animal.name
        typeLabel.text = selected_animal.type
        sexLabel.text = selected_animal.sex
        breedLabel.text = selected_animal.breed
        socialLabel.text = selected_animal.socialToText()
        notesLabel.text = selected_animal.notes
        dateInLabel.text = selected_animal.getDMY_time(d: (selected_animal.reservation?.dateIn)!)
        dateOutLabel.text = selected_animal.getDMY_time(d: (selected_animal.reservation?.dateOut)!)
        checkedInLabel.text = selected_animal.checkedInToText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelEditAnimal(segue: UIStoryboardSegue) {
    }

    @IBAction func saveEditAnimal(segue: UIStoryboardSegue) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "editAnimal":
                let editAnimalVC = segue.destination as! EditAnimalViewController
                editAnimalVC.sel_animal = selected_animal
            case "unwindAnimalInfo":
                let currentClientVC = segue.destination as! CurrentClientViewController
                currentClientVC.sel_animal = selected_animal
            case "removeAnimal": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }


}
