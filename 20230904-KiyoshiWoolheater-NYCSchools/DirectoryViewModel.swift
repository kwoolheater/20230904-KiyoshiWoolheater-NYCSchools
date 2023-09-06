//
//  DirectoryViewModel.swift
//  20230904-KiyoshiWoolheater-NYCSchools
//
//  Created by Woolheater, Kiyoshi on 9/4/23.
//

import Foundation

class DirectoryViewModel {
    
    var directoryList: [DirectoryModel]? {
        didSet {
            listDidChange?(directoryList)
        }
    }
    
    var listDidChange: (([DirectoryModel]?) -> Void)?
    
    init(directoryList: [DirectoryModel]? = nil) {
        self.directoryList = directoryList
    }
    
    func getHighSchoolDirectory() {
        Networking().getData(urlString: "https://data.cityofnewyork.us/resource/f9bf-2cp4.json") { (result: Result<[DirectoryModel], NetworkingError>) in
            switch result {
            case .success(let data):
                self.directoryList = data
            case .failure(let error):
                print(error)
                // Add error handling here
            }
        }
    }
}
