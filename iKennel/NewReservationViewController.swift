//
//  NewReservationViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 4/10/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewReservationViewController: UIViewController, UIPickerViewDelegate {
    
    var clientList = [Contact]()
    var animalList = [Animal]()
    var clients = [Client]()
    @IBOutlet weak var clientPicker: UIPickerView!
    @IBOutlet weak var animalPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getClientfromContacts()
        self.clientPicker.dataSource = self as? UIPickerViewDataSource;
        self.clientPicker.delegate = self
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    
    func getClientfromContacts() {
        for clientContact in clientList{
            for c in clientContact.clients {
                clients.append(c)
            }
        }
        clients.sort { (c1, c2) -> Bool in
            c1.lName < c2.lName
        }
        print(clients)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "addNewReserv":
            guard let reservationTableVC = segue.destination as? ReservationTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
        case "cancelNewReservation": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
 

}
