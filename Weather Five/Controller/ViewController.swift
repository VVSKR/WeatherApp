//
//  ViewController.swift
//  Weather Five
//
//  Created by Vova SKR on 08/08/2019.
//  Copyright © 2019 Vova SKR. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, ChangeCity{
    
    let locationManager = CLLocationManager()
    let networkManager = Networking()
    var weatherModel: WeatherStruct?
    var weatherManager = WeatherModelIcon() // иконка
    let animationsManager = SimpleAnimation() //
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLocationManager()

        
    }
    
    
    func setupViews() {
        wrongLabel.layer.opacity = 0
        iconImage.image = UIImage(named: "Cloud-Refresh")
        tempLabel.text = "--℃"
        cityLabel.text = "Updating..."
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    func reciverCityName(city: String) {
        networkManager.getWeatherDataByCity(city: city) { (result) in
            switch result {
            case .success(let weatherModel):
                DispatchQueue.main.async {
                    self.updateWeatherInfo(info: weatherModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.animationsManager.animationLabel(view: self.wrongLabel)
                }
                print(error.localizedDescription)
            }
        }
    }
    
    
    func updateWeatherInfo(info: WeatherStruct) {
        tempLabel.text = Int(info.main.temp).description + "℃"
        cityLabel.text = info.name
        iconImage.image = UIImage(named: weatherManager.updateIcon(condition: info.weather[0].id))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToWeatherByCity" else { return }
        guard let weatherByCityVC = segue.destination as? WeatherByCity else { return }
        weatherByCityVC.updateWeather = self
    }
}




//MARK: CoreLocation delegate methods

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            print("long = \(location.coordinate.longitude)", "lat = \(location.coordinate.latitude)")
            let latitude = location.coordinate.latitude.description
            let longitude = location.coordinate.longitude.description
            
            networkManager.getWeatherData(lat: latitude, lon: longitude) { (result) in
                switch result {
                case .success(let weatherModel):
                    self.weatherModel = weatherModel
                    DispatchQueue.main.async {
                        self.updateWeatherInfo(info: weatherModel)
                    }
                    print(weatherModel)
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}



