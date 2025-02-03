//
//  WeatherViewController.swift
//  SeSAC-LocationAuthority
//
//  Created by 김정호 on 2/3/25.
//

import UIKit
import SnapKit
import MapKit

final class WeatherViewController: UIViewController {
    
    lazy var locationManager = CLLocationManager()
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.text = "날씨 정보를 불러오는 중..."
        return label
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        locationManager.delegate = self
        
        checkDeviceLocation()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        [mapView, weatherInfoLabel, currentLocationButton, refreshButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        weatherInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
    }
    
    func checkDeviceLocation() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            
            if CLLocationManager.locationServicesEnabled() {
                print(CLLocationManager.locationServicesEnabled())
                // 현재 사용자 위치 권한 상태 확인
                // if 허용된 상태 -> 권한 띄울 필요 x
                // if 거부한 상태 -> 아이폰 설정 이동
                // if notDetermined -> 권한 띄워주기
                print(locationManager.authorizationStatus)
                
                DispatchQueue.main.async {
                    self.checkCurrentLocation()
                }
            } else {
                DispatchQueue.main.async {
                    print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없습니다.")
                }
            }
        }
    }
    
    func checkCurrentLocation() {
        let status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = self.locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        // 선행: info.plist에서 Privacy 항목 추가 -> 위치 서비스에 대한 승인 요청 메서드를 사용할 수 있음
        // 사용자에게 보여지는 권한 얼럿(권한 프롬프트)에는 info.plist에 있는 키의 텍스트가 포함되어 있기 때문
        switch status {
            // 앱이 위치 서비스를 사용할 수 있는지에 대한 여부를 사용자가 선택하지 않은 경우
        case .notDetermined:
            // 배터리로 동작할 때 권장되는 가장 높은 수준의 정확도
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            // 사용자의 위치 권한 관련 정보를 얻기 전에 이 메서드를 요청해야 합니다.
            // 사용자의 권한 승인 상태가 확인이 되지 않은 경우에만 (CLAuthorizationStatus 가 notDetermined 일 경우) 호출이 가능합니다.
            // 그리고 항상 항상 앱이 포그라운드 상태에 있어야 권한 얼럿이 표시됩니다.
            locationManager.requestWhenInUseAuthorization()
            // 사용자가 권한 요청 얼럿에서 앱의 위치 서비스 사용을 거부한 경우
        case .denied:
            showLocationSettingAlert()
            setRegionAndAnnotation(center: CLLocationCoordinate2D(latitude: 37.65421, longitude: 127.0499))
        case .authorizedWhenInUse:
            print("정상 로직 실행하면 됨. 날씨든.")
            //
            locationManager.startUpdatingLocation()
        default:
            print("default - \(status)")
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        setWeatherData(lat: center.latitude, lon: center.longitude)
    }
    
    private func setWeatherData(lat: Double, lon: Double) {
        NetworkManager.shared.fetchWeather(lat: lat, lon: lon) { result in
            switch result {
            case .success(let weatherResponse):
                let temp = weatherResponse.main?.temp
                let tempMin = weatherResponse.main?.tempMin
                let tempMax = weatherResponse.main?.tempMax
                let speed = weatherResponse.wind?.speed
                let humidity = weatherResponse.main?.humidity
                
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "ko_KR")
                formatter.dateFormat = "yyyy년 M월 d일 a hh시 mm분"
                
                self.weatherInfoLabel.text = "\(formatter.string(from: Date()))\n현재온도: \(Int(temp ?? 0))°C\n최저온도: \(Int(tempMin ?? 0))°C\n최고온도: \(Int(tempMax ?? 0))°C\n풍속: \(Int(speed ?? 0))m/s\n습도: \(humidity ?? 0)%"
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func currentLocationButtonTapped() {
        // 현재 위치 가져오기 구현
        checkDeviceLocation()
    }
    
    @objc private func refreshButtonTapped() {
        // 날씨 새로고침 구현
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Aaaaaa")
        print(#function)
        print(locations)
        print(locations.last?.coordinate)
        // 위도, 경도
        // 날씨 정보를 호출하는 API
        // 지도를 현재 위치 중심으로 이동시키는 기능
        
        if let coordinate = locations.last?.coordinate {
            //print(coordinate)
            print(coordinate.latitude)
            setRegionAndAnnotation(center: coordinate)
        }
        
        // start를 했다면, 더이상 위치를 안 받아와도 되는 시점에 stop을 외쳐야 합니다.
        // 계속 위치를 업데이트 시켜야 하는 러닝 앱 등은 다를 수 있음(내 의견)
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 성공적으로 가지고 오지 못한 경우
    // ex. 사용자가 허용 안함 / 자녀 보호 기능 등
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 언제 호출되는가? (1) 사용자의 권한상태가 변경될 때 (2) locationManager 인스턴스가 생성이 될 때
    // ex. 허용 했었지만 시스템에서 안함으로 바꾸는 경우
    // iOS 14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        print("Bbbbb")
        checkDeviceLocation()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
