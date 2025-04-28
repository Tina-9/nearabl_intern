//
//  WelcomeViewController.swift
//  nearabl.swift.exercise
//
//  Created by Fay on 4/27/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    
    @IBOutlet weak var welcomeLabel: UILabel!
    var userEmail: String?
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let email = userEmail {
            welcomeLabel.text = "Welcome, \(email)"
            fetchWeather()
        }
    }
    
    func fetchWeather() {
            let apiKey = "b5a498d97617c2fc25b880587bc40c81"
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=New%20York,us&appid=\(apiKey)&units=metric"
            
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                
                if let weatherInfo = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let main = weatherInfo["main"] as? [String: Any],
                   let temp = main["temp"] as? Double,
                   let weather = (weatherInfo["weather"] as? [[String: Any]])?.first,
                   let icon = weather["icon"] as? String {
                    
                    DispatchQueue.main.async {
                        self.temperatureLabel.text = "NYC Temp: \(temp)°C"
                        self.loadWeatherIcon(icon)
                    }
                }
            }
            task.resume()
        }
        
        func loadWeatherIcon(_ iconCode: String) {
            let iconUrlString = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
            
            guard let url = URL(string: iconUrlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    self.weatherIconImageView.image = image
                }
            }
            task.resume()
        }
}
