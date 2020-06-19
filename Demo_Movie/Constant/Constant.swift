//
//  Constant.swift
//  Demo-Vimal
//
//  Created by Vimal Bosamiya on 06/06/20.
//  Copyright © 2020 Vimal Bosamiya. All rights reserved.
//

import UIKit

let sharedWebCallHelper = APICall.shared()


let APP_DELEGATE = UIApplication.shared.delegate as! AppDelegate

public func downloadImage(from imageUrl:String, completionHandler:@escaping ((_ image:UIImage?)->Void)) {
    let completeImageUrl =  imageUrl
  guard let url = URL(string: completeImageUrl) else {
    completionHandler(nil)
    return
  }
     getData(from: url) { data, response, error in
         guard let data = data, error == nil else { return }
         print(response?.suggestedFilename ?? url.lastPathComponent)
         print("Download Finished \(data)")
         let image = UIImage(data: data)
         completionHandler(image)
     }
 }

public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}
