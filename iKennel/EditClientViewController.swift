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
    @IBOutlet weak var clientStackView: UIStackView!
    @IBOutlet weak var animalLabel: UILabel!
    @IBOutlet weak var editScrollView: UIScrollView!
    
    var cur_client = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstnameTF.text = cur_client.fName
        lastnameTF.text = cur_client.lName
        addressTF.text = cur_client.address
        emailTF.text = cur_client.email
        cellNumTF.text = cur_client.cellNum

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
