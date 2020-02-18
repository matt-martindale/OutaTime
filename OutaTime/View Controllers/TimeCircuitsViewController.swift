//
//  TimeCircuitsViewController.swift
//  OutaTime
//
//  Created by Matthew Martindale on 2/17/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit

class TimeCircuitsViewController: UIViewController, UIPickerViewDelegate, DatePickerDelegate {

    

    //MARK: - Outlets
    @IBOutlet weak var destinationTimeLabel: UILabel!
    @IBOutlet weak var presentTimeLabel: UILabel!
    @IBOutlet weak var lastTimeDepartedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var deloreanButton: UIButton!
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM:dd:yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var currentDate: String = {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM:dd:yyyy"
        let dateTimeString = formatter.string(from: currentDate)
        return dateTimeString
    }()
    
    var currentSpeed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTimeLabel.text = currentDate
        speedLabel.text = "\(currentSpeed) MPH"
        lastTimeDepartedLabel.text = "---:--:----"
 
        
    }
    
    //MARK: - Buttons
    @IBAction func setDestinationTimeButton(_ sender: Any) {
        deloreanButton.isHidden = true
    }
    
    @IBAction func travelBackButton(_ sender: Any) {
        deloreanButton.isHidden = false
//        startTimer()
    }
    
//    func startTimer() {
//        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: )
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalDatePickerSegue" {
            let timeVC = segue.destination as? DatePickerViewController
            timeVC?.delegate = self
        }
    }
    

    func destinationWasChosen(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM:dd:yyyy"
        let dateChosen = formatter.string(from: date)
        destinationTimeLabel.text = dateChosen
//        print(dateChosen)
    }
    
    
}
    

