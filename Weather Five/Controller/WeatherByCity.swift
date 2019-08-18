//
//  WeatherByCity.swift
//  Weather Five
//
//  Created by Vova SKR on 17/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit

class WeatherByCity: UIViewController {
    
    
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var updateWeatherButton: UIButton!
    
    var updateWeather: ChangeCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        notificationCenter()
        hideKeyBoardForTap()
    }
    
    
    func setupView () {
        updateWeatherButton.layer.cornerRadius = 8
        cityTextField.layer.cornerRadius = 8
        cityTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        cityTextField.leftViewMode = .always
        cityTextField.delegate = self
        cityTextField.returnKeyType = UIReturnKeyType.search
        cityTextField.delegate = self
    }
    
    @IBAction func updateWeatherButtonAction(_ sender: UIButton) {
        updateWeather?.reciverCityName(city: cityTextField.text ?? "")
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


extension WeatherByCity: UITextFieldDelegate {
    
    func notificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyBoard(notification:)), name:UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:
            #selector(hideKeyBoard), name:UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc func showKeyBoard(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + 100)
        (self.view as! UIScrollView).scrollIndicatorInsets.bottom = kbFrameSize.height
    }
    
    @objc func hideKeyBoard() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    
    func hideKeyBoardForTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didMissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func didMissKeyboard () {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        updateWeather?.reciverCityName(city: cityTextField.text ?? "")
        dismiss(animated: true, completion: nil)
        return true
    }
}


