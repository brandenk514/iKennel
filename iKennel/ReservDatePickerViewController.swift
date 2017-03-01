//
//  ReservDatePickerViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 3/1/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class ReservDatePickerViewController: UIViewController {

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
        let editReservVC = segue.destination as! EditReservationViewController
        if dateTag == 1 {
            editReservVC.dateIn = datePicker.date
            editReservVC.dateIn_string = formatDateToString(cDate: datePicker.date)
        } else if dateTag == 2 {
            editReservVC.dateOut = datePicker.date
            editReservVC.dateOut_string = formatDateToString(cDate: datePicker.date)
        } else {
            print("No date selected")
        }
    }
    

}
