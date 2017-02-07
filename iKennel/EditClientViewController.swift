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
    
    var fName = ""
    var lName = ""
    var address = ""
    var email = ""
    var cellNum = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstnameTF.text = fName
        lastnameTF.text = lName
        addressTF.text = address
        emailTF.text = email
        cellNumTF.text = cellNum

        // Do any additional setup after loading the view.
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
