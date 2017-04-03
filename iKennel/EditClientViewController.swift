//
//  EditClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/6/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditClientViewController: UIViewController {

    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var cellNumTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!

    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())

    var selected_animal = Animal(name: "", type: "", sex: "", breed: "", social: false, reservation: Reservation(dateIn: Date(), dateOut: Date(), checkedIn: false), notes: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTF.delegate = self as? UITextFieldDelegate
        lastNameTF.delegate = self as? UITextFieldDelegate
        addressTF.delegate = self as? UITextFieldDelegate
        emailTF.delegate = self as? UITextFieldDelegate
        cellNumTF.delegate = self as? UITextFieldDelegate
        
        // Do any additional setup after loading the view.
        firstNameTF.text = cur_client.fName
        lastNameTF.text = cur_client.lName
        addressTF.text = cur_client.address
        emailTF.text = cur_client.email
        cellNumTF.text = cur_client.cellNum

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func firstNameDidChange(_ sender: UITextField) {
        if firstNameTF.text! != cur_client.fName {
            cur_client.fName = firstNameTF.text!
        }
    }
    
    @IBAction func lastNameDidChange(_ sender: UITextField) {
        if lastNameTF.text! != cur_client.lName {
            cur_client.lName = lastNameTF.text!
        }
    }
    
    @IBAction func cellNumDidChange(_ sender: UITextField) {
        if cellNumTF.text! != cur_client.cellNum {
            cur_client.cellNum = cellNumTF.text!
        }
    }
    
    @IBAction func emailDidChange(_ sender: UITextField) {
        if emailTF.text! != cur_client.email {
            cur_client.email = emailTF.text!
        }
    }
    
    @IBAction func addressDidChange(_ sender: UITextField) {
        if addressTF.text! != cur_client.address {
            cur_client.address = addressTF.text!
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "newAnimal" {
            
        } else if segue.identifier == "saveEdit" {
            let curClientVC = segue.destination as! CurrentClientViewController
            curClientVC.cur_client = cur_client
        }
    }


}
