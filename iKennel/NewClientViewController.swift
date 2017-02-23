//
//  NewClientViewController.swift
//  iKennel
//
//  Created by Branden Kaestner on 2/13/17.
//  Copyright © 2017 BK Development. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController {
    
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var cellnum: UITextField!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var breed: UITextField!
    @IBOutlet weak var sex: UISegmentedControl!
    @IBOutlet weak var socialSwitch: UISwitch!
    @IBOutlet weak var notes: UITextField!
    
    @IBOutlet weak var dateInButton: UIButton!
    @IBOutlet weak var dateOutButton: UIButton!
    @IBOutlet weak var checkedInSwitch: UISwitch!
    
    @IBOutlet weak var animalStackView: UIStackView!
    @IBOutlet weak var addAnimalsButton: UIButton!
    
    var dateIn = Date()
    var dateOut = Date()
    
    var dateIn_string = "Date In"
    var dateOut_string = "Date Out"
    
    var dateTag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelDatePicker(segue:UIStoryboardSegue) { }
    @IBAction func addDatePicker(segue:UIStoryboardSegue) {
        dateInButton.setTitle(dateIn_string, for: .normal)
        dateOutButton.setTitle(dateOut_string, for: .normal)
    }

    @IBAction func dateButtonPressed(_ sender: UIButton) {
        if sender.tag == dateInButton.tag {
            dateTag = dateInButton.tag
        } else {
            dateTag = dateOutButton.tag
            performSegue(withIdentifier: "pickDate", sender: sender)
        }
    }
    /*
     Adds UI components for more animals in new Client modal
     */
    
    @IBAction func addPressed(_ sender: Any) {
        print("Pressed")
        var UIArray = [UIView]()
        
        let aLabel = UILabel()
        aLabel.text = "Animal:"
        
        let nameField = UITextField()
        nameField.placeholder = "Name"
        
        let typeControl = UISegmentedControl()
        typeControl.insertSegment(withTitle: "Dog", at: 0, animated: true)
        typeControl.insertSegment(withTitle: "Cat", at: 1, animated: true)
        
        let breedField = UITextField()
        breedField.placeholder = "Breed"
        
        let sexControl = UISegmentedControl()
        sexControl.insertSegment(withTitle: "Male", at: 0, animated: true)
        sexControl.insertSegment(withTitle: "Female", at: 1, animated: true)
        
        var sArray = [UIView]()
        
        let sLabel = UILabel()
        sLabel.text = "Social"
        let sSlider = UISlider()
        sSlider.value = 0.0
        
        sArray.append(sLabel)
        sArray.append(sSlider)
        
        let socialStack = UIStackView(arrangedSubviews: sArray)
        socialStack.axis = .horizontal
        socialStack.distribution = .equalCentering
        socialStack.alignment = .fill
        
        let notesField = UITextField()
        notesField.placeholder = "Notes"
        
        let rLabel = UILabel()
        rLabel.text = "Reservation:"
        
        var dateInArray = [UIView]()
        
        let inLabel = UILabel()
        inLabel.text = "Date In"
        let inButton = UIButton()
        inButton.setTitle("Date In", for: .normal)
        
        dateInArray.append(inLabel)
        dateInArray.append(inButton)
        
        let dateInStack = UIStackView(arrangedSubviews: dateInArray)
        dateInStack.axis = .horizontal
        dateInStack.distribution = .equalCentering
        dateInStack.alignment = .fill
        
        var dateOutArray = [UIView]()
        
        let outLabel = UILabel()
        outLabel.text = "Date Out"
        let outButton = UIButton()
        outButton.setTitle("Date Out", for: .normal)
        
        dateOutArray.append(outLabel)
        dateOutArray.append(outButton)
        
        let dateOutStack = UIStackView(arrangedSubviews: dateOutArray)
        dateOutStack.axis = .horizontal
        dateOutStack.distribution = .equalCentering
        dateOutStack.alignment = .fill
        
        var checkArray = [UIView]()
        
        let checkLabel = UILabel()
        checkLabel.text = "Date Out"
        let checkSwitch = UISwitch()
        checkSwitch.isOn = false
        
        checkArray.append(checkLabel)
        checkArray.append(checkSwitch)
        
        let checkStack = UIStackView(arrangedSubviews: checkArray)
        checkStack.axis = .horizontal
        checkStack.distribution = .equalCentering
        checkStack.alignment = .fill
        
        let addButton = UIButton()
        addButton.setTitle("Add another animal...", for: .normal)
        
        UIArray.append(aLabel)
        UIArray.append(nameField)
        UIArray.append(typeControl)
        UIArray.append(breedField)
        UIArray.append(sexControl)
        UIArray.append(socialStack)
        UIArray.append(notesField)
        UIArray.append(rLabel)
        UIArray.append(dateInStack)
        UIArray.append(dateOutStack)
        UIArray.append(checkStack)
        UIArray.append(addButton)
        
        let stackView = UIStackView(arrangedSubviews: UIArray)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pickDate" {
            let datePickerVC = segue.destination as! DatePickerViewController
            datePickerVC.dateTag = dateTag
        } else {
            let clientTableVC = segue.destination as! ClientTableViewController
            clientTableVC.cFirst = firstname.text!
            clientTableVC.cLast = lastname.text!
            clientTableVC.cAddress = address.text!
            clientTableVC.cEmail = email.text!
            clientTableVC.cCellNum = cellnum.text!
            clientTableVC.animalName = name.text!
            clientTableVC.aType = type.titleForSegment(at: type.selectedSegmentIndex)!
            clientTableVC.aBreed = breed.text!
            clientTableVC.aSex = sex.titleForSegment(at: sex.selectedSegmentIndex)!
            clientTableVC.aSocial = socialSwitch.isOn
            clientTableVC.aNotes = notes.text!
            clientTableVC.resDateIn = dateIn
            clientTableVC.resDateOut = dateOut
            clientTableVC.checkedIn = checkedInSwitch.isOn
        }
        
    }
    
}
