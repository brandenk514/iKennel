//
//  SelectClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 4/10/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class SelectClientViewController: UIViewController, UIPickerViewDelegate {

    var clientList = [Contact]()
    var clients = [Client]()
    
    var selectedClient = Client(fName: "", lName: "", address: "", email: "", cellNum: "", animals: [Animal]())
    
    @IBOutlet weak var clientPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadClientNames()
        self.clientPicker.dataSource = self as? UIPickerViewDataSource;
        self.clientPicker.delegate = self
        selectedClient = clients[0]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clients.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clients[row].lName + ", " + clients[row].fName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedClient = clients[row]
    }
    
    func loadClientNames() {
        for con in clientList {
            for c in con.clients {
                clients.append(c)
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "saveClientPick":
            guard let newReservationVC = segue.destination as? NewReservationViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            newReservationVC.selectedClient = selectedClient
        case "cancelClientPick": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
}
