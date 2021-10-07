//
//  HomeController.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/07.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    // MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ckeckIfUserIsLoggedIn()
        enableLocationServices()
    }
    // MARK: - API
    func ckeckIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureUI()
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("ログアウト失敗")
        }
    }

    // MARK: - Helpers

    func configureUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
}

// MARK: - Location Services
extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self

        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("決定されてない")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("いつでもOK")
            locationManager.startUpdatingHeading()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("ユーザーが許可したときだけOK")
            locationManager.requestAlwaysAuthorization()

        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }


}

