//
//  ViewController.swift
//  Clima
//
//  Created by Tarek Farouk on 6/10/2024.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherDataDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        //assign weatherviewcontroller to be the delegate(مندوب) of searchtextfield
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        // the keyboard disappear
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        
    }
    // this function is called when the user tap the return button(go) in the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
        return true
    }
    // this function is called when the app should end editing
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // here means that if user enter city and don't leave the text field empty
        if textField.text != "" {
            return true
        }else {
            // this will change a placeholder to enter a city to inform the user that he left the text field empty
            textField.placeholder = "Enter a city"
            return false
        }
        
    }
    // this function is called when the app end editing actually and we make this function to clean the textfield for the user if he want to write a new city
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        searchTextField.text = ""
    }
    
    func didUpdateWeather(weather: WeatherModel){
        print(weather.temperature)
    }
    
}



//fc3fa2b59f725a9a577589a8063c9ba3
