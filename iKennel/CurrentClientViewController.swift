//
//  CurrentClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class CurrentClientViewController: UIViewController {
    
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    @IBOutlet weak var clientEmail: UILabel!
    @IBOutlet var animalButtons: [UIButton]!
    
    var sel_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var add_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    var currentAnimalTag = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        clientName.text = cur_client.fName + " " + cur_client.lName
        clientPhone.text = cur_client.cellNum
        clientEmail.text = cur_client.email
        clientAddress.text = cur_client.address
        setAnimalButtons()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clientName.text = cur_client.fName + " " + cur_client.lName
        clientPhone.text = cur_client.cellNum
        clientEmail.text = cur_client.email
        clientAddress.text = cur_client.address
        setAnimalButtons()
    }
    
    @IBAction func animalPressed(_ sender: UIButton) {
        for a in cur_client.animals! {
            if (a.name ==  (sender.titleLabel?.text)!) {
                sel_animal = a // need error check for empty
                break
            }
        }
        currentAnimalTag = sender.tag
        performSegue(withIdentifier: "showAnimalInfo", sender: sender)
    }
    
    @IBAction func cancelCurrentClient(segue:UIStoryboardSegue) { }
    
    @IBAction func editCurrentClient(segue:UIStoryboardSegue) { }
    
    @IBAction func unwindFromNewAnimal(segue:UIStoryboardSegue) { }
    
    @IBAction func removeFromClient(segue:UIStoryboardSegue) {
        cur_client.animals?.remove(at: currentAnimalTag)
    }
    
    @IBAction func saveFromNewAnimal(segue:UIStoryboardSegue) {
        cur_client.animals?.append(add_animal)
    }
    
    @IBAction func unwindToCurrentClient(segue:UIStoryboardSegue) {
        cur_client.animals?[currentAnimalTag] = sel_animal
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAnimalButtons() {
        for b in animalButtons {
            let index = Int(animalButtons.index(of: b)!)
            if index <= ((cur_client.animals?.count)! - 1) {
                b.isHidden = false
                b.isEnabled = true
                b.setTitle(cur_client.animals?[index].name, for: .normal)
                b.tag = index
            } else {
                b.isHidden = true
                b.isEnabled = false
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "editClient":
                let editClientVC = segue.destination as! EditClientViewController
                editClientVC.cur_client = cur_client
            case "showAnimalInfo":
                let cur_animalVC = segue.destination as! CurrentAnimalViewController
                cur_animalVC.selected_animal = sel_animal
            case "doneEditingClient":
                let clientTableVC = segue.destination as! ClientTableViewController
                clientTableVC.editedClient = cur_client
            case "newAnimal": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
}
