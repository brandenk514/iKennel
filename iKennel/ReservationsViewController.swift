//
//  FirstViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 12/29/16.
//  Copyright © 2016 BK Development. All rights reserved.
//

// Animals view

import UIKit

class ReservationsViewController: UIViewController {

    @IBOutlet weak var reservationTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

