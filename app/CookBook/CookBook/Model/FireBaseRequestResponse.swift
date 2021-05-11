//
//  FireBaseRequestResponse.swift
//  CookBook
//
//  Created by Jainam, Himanshu, Ramy on 5/4/21.
//

import Foundation


struct AuthorOfMeal: Decodable {
    let uid: String
    var username: String
    
}


struct Meall: Decodable {
    let id: String
    let author: AuthorOfMeal

    var title:String = "",
        description:String  = "",
        ingredients:String  = "",
        directions:String  = "",
        category: String  = "",
        prepTime: String  = ""
}

class FireBaseRequestResponse: Decodable {
    
}

