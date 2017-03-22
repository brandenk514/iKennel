//
//  EditClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditClientViewController: UIViewController {

    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var cellNumTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!

    @IBOutlet var animalButtons: [UIButton]!

    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())

    var selected_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstnameTF.text = cur_client.fName
        lastnameTF.text = cur_client.lName
        addressTF.text = cur_client.address
        emailTF.text = cur_client.email
        cellNumTF.text = cur_client.cellNum

        for b in animalButtons {
            let index = Int(animalButtons.index(of: b)!)
            if index <= ((cur_client.animals?.count)! - 1) {
                b.setTitle(cur_client.animals?[index].name, for: .normal)
            } else {
                b.isHidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animalPressed(_ sender: UIButton) {
        for a in cur_client.animals! {
            if (a.name == (sender.titleLabel?.text)!) {
                selected_animal = a // need error check for empty
                break
            }
        }
        performSegue(withIdentifier: "editAnimal", sender: sender)
    }

    @IBAction func cancelNewAnimal(segue: UIStoryboardSegue) {
    }

    @IBAction func saveNewAnimal(segue: UIStoryboardSegue) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editAnimal" {
            let editAnimalVC = segue.destination as! EditAnimalViewController
            editAnimalVC.sel_animal = selected_animal
        }

    }


}
