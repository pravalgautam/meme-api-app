//
//  memeData.swift
//  meme gram
//
//  Created by Praval Gautam on 03/05/23.
//

import Foundation


struct Welcome: Codable {
    let postLink: String
    let subreddit, title: String
    let url: String
    let nsfw, spoiler: Bool
    let author: String
    let ups: Int
    let preview: [String]
}


