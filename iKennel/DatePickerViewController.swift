//
//  DatePickerViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/22/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var dateTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatDateToString(cDate:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: cDate)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let newClientVC = segue.destination as! NewClientViewController
        if dateTag == 1 {
            newClientVC.dateIn = datePicker.date
            newClientVC.dateIn_string = formatDateToString(cDate: datePicker.date)
        } else if dateTag == 2 {
            newClientVC.dateOut = datePicker.date
            newClientVC.dateOut_string = formatDateToString(cDate: datePicker.date)
        } else {
            print("No date selected")
        }
        
    }
 

}
