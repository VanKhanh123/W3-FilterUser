//
//  FilterViewController.swift
//  W3-FilterUser
//
//  Created by Văn Khánh Vương on 01/04/2021.
//

import UIKit
protocol FilterViewControllerDelegate {
    func getGenderChoose(gender: String)
    func getLevelChoose(level: String)
}

class FilterViewController: UIViewController {
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var levelSegmentedControl: UISegmentedControl!
    let cityArray: Array = ["Ho Chi Minh","Ha Noi","Da Nang"]
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityTableView.isEditing = true
        self.cityTableView.allowsMultipleSelectionDuringEditing = true
        cleanVariable()
        genderSegmentedControl.addTarget(self, action: #selector(FilterViewController.indexChanged(_:)), for: .valueChanged)
        levelSegmentedControl.addTarget(self, action: #selector(FilterViewController.indexChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        takeCitySelection()
    }
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if genderSegmentedControl.selectedSegmentIndex >= 0 {
            let gender: String = "\(genderSegmentedControl.titleForSegment(at: genderSegmentedControl.selectedSegmentIndex) ?? "")"
            delegate?.getGenderChoose(gender: gender)
        }
        if levelSegmentedControl.selectedSegmentIndex >= 0 {
            let level: String = "\(levelSegmentedControl.titleForSegment(at: levelSegmentedControl.selectedSegmentIndex) ?? "")"
            delegate?.getLevelChoose(level: level)
        }
    }
    func cleanVariable() {
        delegate?.getGenderChoose(gender: "")
        delegate?.getLevelChoose(level: "")
        cityNameArr = []
    }
    
    func takeCitySelection() {
        var cityNameArray = [User]()
        if let selectedIndexCells = self.cityTableView.indexPathsForSelectedRows {
            for indexPath in selectedIndexCells.enumerated() {
                switch indexPath.element.row {
                case 0:
                    cityNameArray.append(User.init(cityName: City.HoChiMinh, userName: "", gender: "", level: ""))
                    break
                case 1:
                    cityNameArray.append(User.init(cityName: City.HaNoi, userName: "", gender: "", level: ""))
                    break
                case 2:
                    cityNameArray.append(User.init(cityName: City.DaNang, userName: "", gender: "", level: ""))
                    break
                default:
                    print("")
                }
            }
        }
        cityNameArr = cityNameArray
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cityArray[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose City :"
    }
    
}
