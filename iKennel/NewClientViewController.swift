//
//  NewClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/13/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController {
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cellnum: UITextField!
    
    @IBOutlet var addAnimalButtons: [UIButton]!
    
    var newAnimal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var animalTag = 0

    var animalArray = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelNewClientAddAnimal(segue:UIStoryboardSegue) { }
    
    @IBAction func saveNewClientAddAnimal(segue:UIStoryboardSegue) {
        animalArray.append(newAnimal)
        for b in addAnimalButtons {
            if animalTag == b.tag {
                b.setTitle(newAnimal.name, for: .normal)
            }
        }
    }

    @IBAction func addAnimalPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addAnimal", sender: sender)
        animalTag = sender.tag
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "unwindToClientTable": break
        case "addAnimal": break
        case "unwindSaveToClientTable":
            let clientTableVC = segue.destination as! ClientTableViewController
            clientTableVC.cFirst = firstname.text!
            clientTableVC.cLast = lastname.text!
            clientTableVC.cAddress = address.text!
            clientTableVC.cEmail = email.text!
            clientTableVC.cCellNum = cellnum.text!
            clientTableVC.animalArray = animalArray
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
        
    }
    
}
