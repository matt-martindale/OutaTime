//
//  DatePickerViewController.swift
//  OutaTime
//
//  Created by Matthew Martindale on 2/17/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

protocol DatePickerDelegate {
    func destinationWasChosen(date: Date)
}

class DatePickerViewController: UIViewController {

    @IBOutlet weak var timeDatePicker: UIDatePicker!
    
    var delegate: DatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        delegate?.destinationWasChosen(date: timeDatePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
}
