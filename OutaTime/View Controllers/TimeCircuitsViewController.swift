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
    @IBOutlet weak var travelBackButton: UIButton!
    
    var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM:dd:yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }()
    
    var currentDate: String = {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM : dd : yyyy"
        let dateTimeString = formatter.string(from: currentDate)
        return dateTimeString
    }()
    
    var currentSpeed = 0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentTimeLabel.text = currentDate
        speedLabel.text = "\(currentSpeed) MPH"
        lastTimeDepartedLabel.text = "--- : -- : ----"
        travelBackButton.isEnabled = false
        
    }
    
    //MARK: - Buttons
    @IBAction func setDestinationTimeButton(_ sender: Any) {
        deloreanButton.isHidden = true
        timer?.invalidate()
        speedLabel.text = "0 MPH"
        currentSpeed = 0
        travelBackButton.isEnabled = true
    }
    
    @IBAction func travelBackButton(_ sender: Any) {
        startTimer()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {_ in
            self.currentSpeed += 1
            self.speedLabel.text = String("\(self.currentSpeed) MPH")
            if self.currentSpeed == 88 {
                self.timer?.invalidate()
                self.showAlert()
                self.lastTimeDepartedLabel.text = self.presentTimeLabel.text
                self.presentTimeLabel.text = self.destinationTimeLabel.text
            }
        })
        travelBackButton.isEnabled = false
    }
    
    func showDelorean() {
        deloreanButton.isHidden = false
    }
    
    func showAlert() {
        if let destinationTime = destinationTimeLabel.text {
        let alert = UIAlertController(title: "Time Travel Successful", message: "You're new date is \(destinationTime)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "This is heavy", style: .default, handler: {(alert: UIAlertAction!) in self.showDelorean()})
        let deferAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "We must go back!", style: .destructive, handler: {(alert: UIAlertAction!) in
                self.currentSpeed = 0
                self.speedLabel.text = "0 MPH"
                self.destinationTimeLabel.text = self.lastTimeDepartedLabel.text
                self.startTimer() })
        
        alert.addAction(okAction)
        alert.addAction(deferAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ModalDatePickerSegue" {
            let timeVC = segue.destination as? DatePickerViewController
            timeVC?.delegate = self
        }
    }
    

    func destinationWasChosen(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM : dd : yyyy"
        let dateChosen = formatter.string(from: date)
        destinationTimeLabel.text = dateChosen
    }
    
    
}
    

