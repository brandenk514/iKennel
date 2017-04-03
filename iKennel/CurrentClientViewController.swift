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
    @IBOutlet weak var clientStackView: UIStackView!
    @IBOutlet weak var secondAnimalStack: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    
    var sel_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")
    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    var currentClientIndex = 0
    var currentClientSection = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        clientName.text = cur_client.fName + " " + cur_client.lName
        clientPhone.text = cur_client.cellNum
        clientEmail.text = cur_client.email
        clientAddress.text = cur_client.address
        
        for b in animalButtons {
            let index = Int(animalButtons.index(of: b)!)
            if index <= ((cur_client.animals?.count)! - 1) {
                b.setTitle(cur_client.animals?[index].name, for: .normal)
            } else {
                b.isHidden = true
            }
        }
        if  (cur_client.animals?.count)! < 5 {
            secondAnimalStack.isHidden = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clientName.text = cur_client.fName + " " + cur_client.lName
        clientPhone.text = cur_client.cellNum
        clientEmail.text = cur_client.email
        clientAddress.text = cur_client.address
    }
    
    @IBAction func animalPressed(_ sender: UIButton) {
        for a in cur_client.animals! {
            if (a.name ==  (sender.titleLabel?.text)!) {
                sel_animal = a // need error check for empty
                break
            }
        }
        performSegue(withIdentifier: "showAnimalInfo", sender: sender)
    }
    
    @IBAction func cancelCurrentClient(segue:UIStoryboardSegue) { }
    
    @IBAction func editCurrentClient(segue:UIStoryboardSegue) { }
    
    @IBAction func unwindToCurrentClient(segue:UIStoryboardSegue) { }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
}
