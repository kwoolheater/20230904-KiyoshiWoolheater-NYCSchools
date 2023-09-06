//
//  ViewController.swift
//  20230904-KiyoshiWoolheater-NYCSchools
//
//  Created by Woolheater, Kiyoshi on 9/4/23.
//

import UIKit

class DirectoryTableViewController: UITableViewController {

    var directoryViewModel = DirectoryViewModel(directoryList: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "High Schools"
        
        directoryViewModel.getHighSchoolDirectory()
        
        directoryViewModel.listDidChange = { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension DirectoryTableViewController {
    // MARK: Table View Delegate Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directoryViewModel.directoryList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolNameCell", for: indexPath) as! SchoolNameCell
        cell.name.text = directoryViewModel.directoryList?[indexPath.row].schoolName.normalizeCapitalization() ?? ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedSchool = directoryViewModel.directoryList?[indexPath.row] {
            let detailsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "schoolDetailViewController") as! SchoolDetailViewController
            detailsViewController.school = selectedSchool
            self.navigationController?.pushViewController(detailsViewController, animated: true)
        } else {
            print("Error loading schools")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

