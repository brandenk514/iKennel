//
//  TableViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 1/24/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var clients = Client.loadAllClients()
    
    var animals = [Animal]()
    
    var contacts = [String: [Client]]()
    
    var dates: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for c in clients {
            for a in c.animals! {
                animals.append(a)
            }
        }

        dates = clients.map { (name) -> String in
            return getDMY(d:name.animals![0].getReservation().dateIn)
        }
        //print(dates)
        dates = dates.reduce([], { (list, name) -> [String] in
            if !list.contains(name) {
                return list + [name]
            }
            return list
        })
        //print(dates)
        
        /*for c in clients {
            if contacts[getDMY(d:c.animals![0].getReservation().getDateIn())[getDMY(d:c.animals![0].getReservation().getDateIn()).startIndex]] == nil {
                contacts[c.lName[c.lName.startIndex]] = [Client]()
            }
            
            contacts[c.lName[c.lName.startIndex]]!.append(c)
        }
        
        dates.sort()
        
        for (letter, list) in contacts {
            contacts[letter] = list.sorted(by: { (client1, client2) -> Bool in
                client1.lName < client2.lName
            })
        }*/
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
        return clients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Name", for: indexPath) as! MainTableViewCell
        
        cell.clientName?.text = clients[indexPath.row].lName + ", " + clients[indexPath.row].fName
        cell.animalNames?.text = "Pets: " + clients[indexPath.row].getAnimalNames()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(Array(dates)[section])
    }
    
    @IBAction func addNewReservation(segue:UIStoryboardSegue) {
    }
    
    @IBAction func cancelNewReservation(segue:UIStoryboardSegue) {
    }
    
    @IBAction func editCurrentReservation(segue:UIStoryboardSegue) {
    }
    
    @IBAction func cancelCurrentReservation(segue:UIStoryboardSegue) {
    }
    
    func getDMY(d:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: d)
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
        /* Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let editClientVC = segue.destination as! EditClientViewController
        editClientVC.lName = self.lName
        editClientVC.fName = self.fName
        editClientVC.address = self.address
        editClientVC.email = self.email
        editClientVC.cellNum = self.cellNum
        */
        
    }
    
}
