//
//  HomeController.swift
//  UberTutorial
//
//  Created by minmin on 2021/10/07.
//

import UIKit
import Firebase
import MapKit

private let reuseIdentifier = "LocationCell"

class HomeController: UIViewController {
    // MARK: - Properties
    private let mapView = MKMapView()
    private let locationManager = LocationHandler.shared.locationManager

    private let inputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
    private let tableView = UITableView()

    private var user: User? {
        didSet { locationInputView.user = user }
    }

    private final let locationInputViewHeight: CGFloat = 200

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ckeckIfUserIsLoggedIn()
        enableLocationServices()
//        fetchUserData()
        signOut()
    }
    // MARK: - API

    func fetchUserData() {
        Service.shared.fetchUserData { user in
            self.user = user
        }
    }

    func ckeckIfUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
//                    configureUI()

            }
        } else {
            configureUI()
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("ログアウト失敗")
        }
    }

    // MARK: - Helpers

    func configureUI() {
        configureMapView()
        view.addSubview(inputActivationView)
        inputActivationView.centerX(inView: view)
        inputActivationView.setDimensions(height: 50, width: view.frame.width - 64)
        inputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        inputActivationView.alpha = 0
        inputActivationView.delegate = self

        UIView.animate(withDuration: 2) {
            self.inputActivationView.alpha = 1
        }

        configureTableView()
    }

    func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    func configureLocationInputView() {
        locationInputView.delegate = self
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            self.locationInputView.alpha = 1
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
        }
    }

    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 60
        tableView.tableFooterView = UIView()
        let height = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height,
                                 width: view.frame.width, height: height)
        view.addSubview(tableView)
    }

}

// MARK: - Location Services
extension HomeController {
    func enableLocationServices() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("決定されてない")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("いつでもOK")
            locationManager?.startUpdatingHeading()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("ユーザーが許可したときだけOK")
            locationManager?.requestAlwaysAuthorization()

        default:
            break
        }
    }
}


// MARK: - LocationInputActivationViewDelegate

extension HomeController: LocationInputActivationViewDelegate {
    func presentLocationInputView() {
        inputActivationView.alpha = 0
        configureLocationInputView()
    }
}

// MARK: - LocationInputActivationViewDelegate

extension HomeController: LocationInputViewDelegate {
    func dissmissLocationInputView() {

        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.inputActivationView.alpha = 1
            }
        }

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource



extension HomeController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "test"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LocationCell
        return cell
    }

}
