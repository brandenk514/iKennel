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
    @IBOutlet weak var clientEmail: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    @IBOutlet weak var animalButton: UIButton!

    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    var aNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clientName.text = cur_client.fName + " " + cur_client.lName
        clientPhone.text = cur_client.cellNum
        clientEmail.text = cur_client.email
        clientAddress.text = cur_client.address
        
        animalButton.setTitle(getAnimalNames(), for: .normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAnimalNames() -> String {
        for a in cur_client.animals! {
            aNames.append(a.name)
        }
        return aNames.joined(separator: ", ")
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editClient" {
            let editClientVC = segue.destination as! EditClientViewController
            editClientVC.cur_client = self.cur_client
        }
    }
}
