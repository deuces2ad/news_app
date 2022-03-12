//
//  NewsFeedResponse.swift
//  NewsApp
//
//  Created by Apple on 12/03/22.
//



import Foundation

// MARK: - NewsFeedResponse
struct NewsFeedResponse: Decodable {
    var status: String?
    var feed: Feed?
    var items: [Item]?
}

// MARK: - Feed
struct Feed: Decodable {
    var url: String?
    var title: String?
    var link: String?
    var author, feedDescription: String?
    var image: String?

    enum CodingKeys: String, CodingKey {
        case url, title, link, author
        case feedDescription
        case image
    }
}

// MARK: - Item
struct Item: Decodable,Identifiable {
    let id = UUID()
    var title, pubDate: String?
    var link, guid: String?
    var author: String?
    var thumbnail: String?
    var itemDescription, content: String?
    var enclosure: Enclosure?
    var categories: [String]?

    enum CodingKeys: String, CodingKey {
        case title, pubDate, link, guid, author, thumbnail
        case itemDescription
        case content, enclosure, categories
    }
}

// MARK: - Enclosure
struct Enclosure: Decodable {
    var link: String?
    var type: String?
    var thumbnail: String?
}
