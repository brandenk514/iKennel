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
    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // list all buttons individually, then add to array and loop through with names
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editClient" {
            let editClientVC = segue.destination as! EditClientViewController
            editClientVC.cur_client = cur_client
        }
    }
}
