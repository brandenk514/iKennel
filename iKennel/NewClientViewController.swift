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
    
    var name = ""
    var type = ""
    var breed = ""
    var sex = ""
    var notes = ""
    var social = false
    
    var dateIn = Date()
    var dateOut = Date()
    
    var checkedIn = false

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

    @IBAction func cancelAddAnimal(segue:UIStoryboardSegue) { }
    @IBAction func saveAddAnimal(segue:UIStoryboardSegue) {
        addAnimal()
        for b in addAnimalButtons {
            if animalTag == b.tag {
                b.setTitle(name, for: .normal)
            }
        }
    }

    @IBAction func addAnimalPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "addAnimal", sender: sender)
        animalTag = sender.tag
    }

    func addAnimal() {
        let tempReservation = Reservation(dateIn: dateIn, dateOut: dateOut, checkedIn: checkedIn)
        let tempAnimal = Animal(name: name, type: type, sex: sex, breed: breed, social: social, reservation: tempReservation, notes: notes)
        animalArray.append(tempAnimal)
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "addAnimal" {
            let addAnimalVC = segue.destination as! AddAnimalViewController
            addAnimalVC.animalTag = animalTag
        } else {
            let clientTableVC = segue.destination as! ClientTableViewController
            clientTableVC.cFirst = firstname.text!
            clientTableVC.cLast = lastname.text!
            clientTableVC.cAddress = address.text!
            clientTableVC.cEmail = email.text!
            clientTableVC.cCellNum = cellnum.text!
            clientTableVC.animalArray = animalArray
        }
        
    }
    
}
