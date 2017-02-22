//
//  CurrentAnimalViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/22/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class CurrentAnimalViewController: UIViewController {
    
    var selected_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var current_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var socialLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var dateInLabel: UILabel!
    @IBOutlet weak var dateOutLabel: UILabel!
    @IBOutlet weak var checkedInLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = selected_animal.name
        typeLabel.text = selected_animal.type
        sexLabel.text = selected_animal.sex
        breedLabel.text = selected_animal.breed
        socialLabel.text = boolToString(b: selected_animal.social)
        notesLabel.text = selected_animal.notes
        dateInLabel.text = formatDate(cDate: (selected_animal.reservation?.dateIn)!)
        dateOutLabel.text = formatDate(cDate: (selected_animal.reservation?.dateOut)!)
        checkedInLabel.text = boolToString(b: (selected_animal.reservation?.checkedIn)!)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func boolToString(b: Bool) -> String {
        if b {
            return "Yes"
        } else {
            return "No"
        }
    }
    
    func formatDate(cDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: cDate)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editClientfromAnimal" {
            let editClientVC = segue.destination as! EditClientViewController
            editClientVC.cur_client = current_client
        }
    }
 

}
