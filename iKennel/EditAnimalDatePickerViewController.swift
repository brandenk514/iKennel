//
//  EditAnimalDatePickerViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 4/10/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class EditAnimalDatePickerViewController: UIViewController {
    
    var dateTag = 0
    var editDatePickerdateIn = Date()
    var editDatePickerdateOut = Date()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func chooseDate() {
        if dateTag == 1 {
            editDatePickerdateIn = datePicker.date
        } else if dateTag == 2  {
            editDatePickerdateOut = datePicker.date
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "unwindSaveToEditAnimal":
            guard let editAnimalVC = segue.destination as? EditAnimalViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            chooseDate()
            editAnimalVC.dateIn = editDatePickerdateIn
            editAnimalVC.dateIn_string = formatDateToString(cDate: editDatePickerdateIn)
            editAnimalVC.dateOut = editDatePickerdateOut
            editAnimalVC.dateOut_string = formatDateToString(cDate: editDatePickerdateOut)
        case "unwindToEditAnimal": break
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "Empty")")
        }
    }
 

}
