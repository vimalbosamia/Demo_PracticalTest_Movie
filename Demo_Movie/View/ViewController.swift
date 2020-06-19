//
//  ViewController.swift
//  Demo_Movie
//
//  Created by Vimal on 18/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var page: Int = 1
    var arrayMovie = [Movie]()
    var refresh: Delay!
    
    @IBOutlet weak var movieTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTblView.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        //refresh = Delay(delay: 0.1) {
                    self.callAPI(pageIndex:1)
          //     }
               prepareView()
    }
    
     override func viewWillAppear(_ animated: Bool) {
    
       
    }
    
    func prepareView() {
        movieTblView.tableFooterView = UIView()
    }
}

//MARK:- API
extension ViewController{
    func callAPI(pageIndex : Int){
        Movie.getUserList(page: pageIndex) { (movie, error) in
                if let array = movie, array.count > 0 {
                    self.arrayMovie.append(contentsOf: array)
                    print(self.arrayMovie)
                    self.movieTblView.reloadData()
                } else if let errorMsg = error?.localizedDescription {
           
            }
        }
    }
}

//MARK:- TableView Delegate And DataSource

extension ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? movieCell else { return UITableViewCell() }
        let movie = arrayMovie[indexPath.row]
        cell.movie = movie
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 221
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
         if indexPath.row == arrayMovie.count - 1 {
            page = page + 1
            self.callAPI(pageIndex:page)
         }
        
    }
}

