//
//  NDLocationManager.swift
//  HikingClub
//
//  Created by AhnSangHoon on 2021/11/25.
//

import CoreLocation
import RxCocoa
import RxSwift

final class NDLocationManager: NSObject {
    static let shared = NDLocationManager()
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    private let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.startUpdatingLocation()
        return manager
    }()

    var currentCoordinate: (Double, Double)?
    fileprivate let _didUpdateLocation = BehaviorRelay<(Double, Double)?>(value: nil)
    
    var locationAuthStatus: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    func requestLocationAuth(_ handler: @escaping (() -> Void)) {
        switch locationAuthStatus {
        case .authorizedWhenInUse:
            fallthrough
        case .authorizedAlways:
            handler()
        case .restricted:
            fallthrough
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            // TODO: 권한 거부 상태일때의 처리 추가해야함
            break
        default:
            // TODO: 추가된 상태에 대한 처리 추가해야함
            print(locationAuthStatus)
        }
    }
}

extension NDLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        let locataion = (coordinate.latitude, coordinate.longitude)
        currentCoordinate = locataion
        _didUpdateLocation.accept(locataion)
        locationManager.stopUpdatingLocation()
    }
}


extension Reactive where Base: NDLocationManager {
    var didUpdateLocation: Observable<(Double, Double)> {
        base._didUpdateLocation
            .compactMap { $0 }
            .asObservable()
    }
}

