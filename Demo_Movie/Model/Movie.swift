//
//  Movie.swift
//  Demo_Movie
//
//  Created by Vimal on 18/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import Foundation


//{
//     "popularity": 11.119,
//     "vote_count": 3018,
//     "video": false,
//     "poster_path": "/5F1sINO5CGUh9tK6eGg8mRCPhQM.jpg",
//     "id": 2787,
//     "adult": false,
//     "backdrop_path": "/mZGwhwIwYuF0G9XLS8j23dhNfUC.jpg",
//     "original_language": "en",
//     "original_title": "Pitch Black",
//     "genre_ids": [
//       28,
//       878,
//       53
//     ],
//     "title": "Pitch Black",
//     "vote_average": 6.8,
//     "overview": "When their ship crash-lands on a remote planet, the marooned passengers soon learn that escaped convict Riddick isn't the only thing they have to fear. Deadly creatures lurk in the shadows, waiting to attack in the dark, and the planet is rapidly plunging into the utter blackness of a total eclipse. With the body count rising, the doomed survivors are forced to turn to Riddick with his eerie eyes to guide them through the darkness to safety. With time running out, there's only one rule: Stay in the light.",
//     "release_date": "2000-02-18"
//   },
class Movie: NSObject {
    
    struct Key
    {
        fileprivate static let voteCount = "vote_count"
        fileprivate static let id = "id"
        fileprivate static let video = "video"
        fileprivate static let voteAverage = "vote_average"
        fileprivate static let title = "title"
        fileprivate static let posterPath = "poster_path"
        fileprivate static let originalTitle = "original_title"
        fileprivate static let genreIds = "genre_ids"
        fileprivate static let backdropPath = "backdrop_path"
        fileprivate static let adult = "adult"
        fileprivate static let overview = "overview"
        fileprivate static let releaseDate = "release_date"

    }
   
    
    var title:String?
    var overview:String?
    var posterPath:String?
    var rating : Float?
    var releaseDate : String?
    
    
    var posterUrlString: String? {
        if let posterPath = posterPath {
            return "https://image.tmdb.org/t/p/w300\(posterPath)"
        }
        return nil
    }
    
    
    override init() {
         
     }
     
     init(fromDictionary dictionary: [String:Any]) {
         title = dictionary[Key.title] as? String
         overview = dictionary[Key.overview] as? String
         posterPath = dictionary[Key.posterPath] as? String
         rating = dictionary[Key.voteAverage] as? Float
         releaseDate = dictionary[Key.releaseDate] as? String
     }
     
     
     class func getUserList(page:Int,completion: @escaping ([Movie]?, Error?) -> Void) {
         let urlPath = WebCallPath.GetUserList
         let method = WebCallType.get
        
        let queryParam = [
                   "api_key": movieApiKey,
                   "language": "en-US",
                   "sort_by" : "popularity.desc",
                   "primary_release_date.gte" : "2000-01-01",
                   "vote_count.gte" : "3000",
                   "page": "\(page)"
               ]
         _ = sharedWebCallHelper.callWebService(withUrlStr: urlPath, httpMethod: method, queryParams: queryParam, bodyParams: nil, withCompletionHandler: { (response, error) in
             if let jsonObject = response {
                 print("jsonObject is \(jsonObject)")
                 if let array = jsonObject["results"] as? [[String:Any]], array.count > 0 {
                     let data = array.map { (object) -> Movie in
                         return Movie(fromDictionary: object)
                     }
                     completion(data, nil)
                 } else {
                     completion(nil, nil)
                 }
             }else {
                 completion(nil, error)
             }
             
         })
     }
}

