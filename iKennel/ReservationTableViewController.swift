//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ReservationTableViewController: UITableViewController {
    
    var clients = Client.loadAllClients()
    
    var animals = [Animal]()
    
    var contacts = [String: [Animal]]()
    
    var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indexReservations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dates.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts[dates[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reservation", for: indexPath) as! ReservationTableViewCell
        let selected = contacts[dates[indexPath.section]]?[indexPath.row]
        cell.clientName.text = selected?.name
        cell.animalNames.text = selected?.convertBoolToText()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dates[section]
    }
    
    @IBAction func addNewReservation(segue:UIStoryboardSegue) {
    }
    
    @IBAction func cancelNewReservation(segue:UIStoryboardSegue) {
    }
    
    func indexReservations() {
        for c in clients {
            for a in c.animals! {
                animals.append(a)
            }
        }
        
        for a in animals {
            let key = "\(a.getDMY(d: (a.reservation?.dateIn)!))"
            let upper = key.uppercased()
            
            if var dateValues = contacts[upper] {
                dateValues.append(a)
                contacts[upper] = dateValues
            } else {
                contacts[upper] = [a]
            }
        }
        
        dates = [String](contacts.keys)
        dates.sort()
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "currentReservation" {
            let currentReservationVC = segue.destination as! CurrentReservationViewController
            let index: Int = (self.tableView.indexPathForSelectedRow?.row)!
            let section: Int = (self.tableView.indexPathForSelectedRow?.section)!
            currentReservationVC.cur_animal = (contacts[dates[section]]?[index])!
        }
    }
    
}
