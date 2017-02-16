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
    @IBOutlet weak var animalNames: UILabel!
    
    var fName = ""
    var lName = ""
    var email = ""
    var address = ""
    var cellNum = ""
    var animals = [Animal]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clientName.text = fName + " " + lName
        clientPhone.text = cellNum
        clientEmail.text = email
        clientAddress.text = address
        animalNames.text = getAnimalNames()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAnimalNames() -> String {
        var aNames = [String]()
        for a in animals {
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
            editClientVC.lName = self.lName
            editClientVC.fName = self.fName
            editClientVC.address = self.address
            editClientVC.email = self.email
            editClientVC.cellNum = self.cellNum
        }
    }
}
