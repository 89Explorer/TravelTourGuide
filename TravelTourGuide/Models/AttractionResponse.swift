//
//  AttractionResponse.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/4/24.
//


import Foundation

struct AttractionResponse: Codable {
    let response: Response
}

struct Response: Codable {
    let header: Header
    let body: Body
}

struct Header: Codable {
    let resultCode: String
    let resultMsg: String
}

struct Body: Codable {
    let items: Items
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct Items: Codable {
    let item: [Item]
}

struct Item: Codable {
    let addr1: String?
    let addr2: String?
    let areacode: String?
    let booktour: String?
    let cat1: String?
    let cat2: String?
    let cat3: String?
    let contentid: String
    let contenttypeid: String
    let createdtime: String?
    let firstimage: String?
    let firstimage2: String?
    let cpyrhtDivCd: String?
    let mapx: String?
    let mapy: String?
    let mlevel: String?
    let modifiedtime: String?
    let sigungucode: String?
    let tel: String?
    let title: String?
    let zipcode: String?
}

