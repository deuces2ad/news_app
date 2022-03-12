//
//  RoutesListingController.swift
//  HealthTracker
//
//  Created by Apple on 26/10/21.
//

import Foundation
import UIKit

class RoutesListingController : InterfaceExtendedController{
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTblViewCell()
    
    }
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    //MARK: - Set RootView
    lazy var rootView : RoutesListingRootView = {
        let rootView = RoutesListingRootView()
        rootView.backgroundColor = .red
        return rootView
    }()
    
    let appointmentArr = [
    "Delhi",
    "pathankot",
    "Banglore",
    "Delhi",
    "pathankot",
    "Banglore",
    "pathankot",
    "Banglore"]
    
    func registerTblViewCell(){
//        Log.echo(key: "New ArrList", text: "\(appointmentArr)")
        rootView.appointmentsTblView.delegate = self
        rootView.appointmentsTblView.dataSource = self
        rootView.appointmentsTblView.register(UITableViewCell.self, forCellReuseIdentifier: "AppointmentsCell")
    }

    
}

extension RoutesListingController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentsCell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = appointmentArr[indexPath.row]
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 550.0
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        return 110
//    }
}
