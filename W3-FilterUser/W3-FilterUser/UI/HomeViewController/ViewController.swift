//
// ViewController.swift
// W3-FilterUser
//
// Created by Văn Khánh Vương on 31/03/2021.
//

import UIKit


var cityNameArr = [User]()

class ViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    let identifier = "MyTableViewCell"
    var user = [User]()
    var genderChoose = ""
    var levelChoose = ""
    var cities: [City] = [.HoChiMinh, .HaNoi, .DaNang]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: identifier, bundle: nil)
        userTableView.register(nib, forCellReuseIdentifier: identifier)
        userTableView.delegate = self
        userTableView.dataSource = self
        setupNavigationBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpCityArray()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.user.removeAll()
    }
    
    func afterFilter() {
        createData()
        if (!genderChoose.isEmpty || !levelChoose.isEmpty || !cityNameArr.isEmpty) {
            self.userTableView.reloadData()
        }
    }
    
    func setUpCityArray() {
        createData()
        // Nếu mảng cityNameArr có gía trị => Giá trị dược trả về
        if !cityNameArr.isEmpty {
            // Map những user có thành phố tương ứng
            cities = cityNameArr.map { (user) -> City in
                return user.city
            }
        }
        self.userTableView.reloadData()
    }
    // Hàm tạo Data
    func createData() {
        user.append(User.init(cityName: City.HoChiMinh, userName: "Khanh Vuong", gender: "Male", level: "Gold"))
        user.append(User.init(cityName: City.HaNoi, userName: "Khanh Vy", gender: "Female", level: "Silver"))
        user.append(User.init(cityName: City.DaNang, userName: "Tuan Nghia", gender: "Male", level: "Diamond"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Khanh Linh", gender: "Female", level: "Silver"))
        user.append(User.init(cityName: City.HaNoi, userName: "Ba Mao", gender: "Male", level: "Gold"))
        user.append(User.init(cityName: City.DaNang, userName: "Ngoc Ngan", gender: "Female", level: "Diamond"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Ngoc Khang", gender: "Male", level: "Diamond"))
        user.append(User.init(cityName: City.HaNoi, userName: "Quoc Bao", gender: "Male", level: "Gold"))
        user.append(User.init(cityName: City.DaNang, userName: "Ngoc Van", gender: "Female", level: "Silver"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Kim Loan", gender: "Female", level: "Gold"))
        user.append(User.init(cityName: City.HaNoi, userName: "Ngoc Nhu", gender: "Female", level: "Silver"))
        user.append(User.init(cityName: City.DaNang, userName: "Khanh Hoang", gender: "Male", level: "Diamond"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Huynh Nhu", gender: "Female", level: "Silver"))
        user.append(User.init(cityName: City.HaNoi, userName: "Nhat Thong", gender: "Male", level: "Diamond"))
        user.append(User.init(cityName: City.DaNang, userName: "Kim Lien", gender: "Female", level: "Gold"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Hong Loan", gender: "Female", level: "Diamond"))
        user.append(User.init(cityName: City.HaNoi, userName: "Kim Phung", gender: "Female", level: "Gold"))
        user.append(User.init(cityName: City.DaNang, userName: "Huu Chinh", gender: "Male", level: "Silver"))
        user.append(User.init(cityName: City.HaNoi, userName: "Huu Linh", gender: "Male", level: "Silver"))
        user.append(User.init(cityName: City.HaNoi, userName: "Khac Hoan", gender: "Female", level: "Diamond"))
        user.append(User.init(cityName: City.DaNang, userName: "Nguyen Hung", gender: "Male", level: "Gold"))
        user.append(User.init(cityName: City.HoChiMinh, userName: "Hung Thanh", gender: "Male", level: "Silver"))
    }
    
    // Hàm push qua view filter
    @objc func handleFiler() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let filterView = storyBoard.instantiateViewController(identifier: "FilterView") as! FilterViewController
        filterView.delegate = self
        self.navigationController?.pushViewController(filterView, animated: true)
        
    }
    
    func filterUser(city: City) -> Array<User> {
        let afterFilterGenderArray = genderChoose.isEmpty ? user : user.filter { value in
            value.gender == genderChoose
        }
        let afterFilterLevelArray = levelChoose.isEmpty ? afterFilterGenderArray : afterFilterGenderArray.filter { $0.level == levelChoose }
        let afterFilterCityArray = afterFilterLevelArray.filter { (user) -> Bool in
            user.city == city
        }
        return afterFilterCityArray
    }
    
    // Hàm khởi tạo nút Filter (Hình phễu) trong ViewController
    func setupNavigationBarItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "filter"), style: .plain, target: self, action: #selector(handleFiler))
    }
    
    func printNumberOfRowsInSection(section: Int) -> Int {
        var numberOfRow: Int = 0
        if (!genderChoose.isEmpty || !levelChoose.isEmpty || !cityNameArr.isEmpty) {
            numberOfRow = filterUser(city: cities[section]).count
        } else {
            numberOfRow = self.user.count
        }
        return numberOfRow
    }
    
    func printNumberOfSections() -> Int {
        var numberOfSection: Int = 0
        if (!genderChoose.isEmpty || !levelChoose.isEmpty || !cityNameArr.isEmpty) {
            numberOfSection = cities.count
        } else {
            numberOfSection = 1
        }
        return numberOfSection
    }
    
    func printCellForRowAt(indexPath:IndexPath) -> [User] {
        var users = [User]()
        if (!genderChoose.isEmpty || !levelChoose.isEmpty || !cityNameArr.isEmpty) {
            users = cities.count == 0 ? user : filterUser(city: cities[indexPath.section])
        } else {
            users = self.user
        }
        return users
    }
    
    func printTitleForHeaderInSection(section: Int) -> String {
        var string: String = ""
        if (cityNameArr.isEmpty && genderChoose.isEmpty && levelChoose.isEmpty) {
            string = "All (\(self.user.count))"
        } else {
            if (!genderChoose.isEmpty && !levelChoose.isEmpty && !cityNameArr.isEmpty) {
                string =  cities.count == 0 ? "" : cities[section].rawValue + " (\(filterUser(city: cities[section]).count))"
            } else if (!genderChoose.isEmpty && !levelChoose.isEmpty && cityNameArr.isEmpty){
                string = ""
            }
        }
        return string
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let numberOfRow = filterUser(city: cities[section]).count
        return printNumberOfRowsInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //let numberOfSecti on = cities.count
        return printNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MyTableViewCell
        //let users = cities.count == 0 ? user : filterUser(city: cities[indexPath.section])
        let users = printCellForRowAt(indexPath: indexPath)
        cell.userNameLabel.text = users[indexPath.row].userName
        cell.genderLabel.text = users[indexPath.row].gender
        cell.levelLabel.text = users[indexPath.row].level
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return printTitleForHeaderInSection(section: section)
    }
}

extension ViewController: FilterViewControllerDelegate {
    func getGenderChoose(gender: String) {
        self.genderChoose = gender
    }
    func getLevelChoose(level: String) {
        self.levelChoose = level
    }
}
