//
//  AttractionIntroInfo.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/7/24.
//

import Foundation

struct AttractionIntroInfoResponseResponse: Codable {
    let response: AttractionIntroInfoResponse
}

struct AttractionIntroInfoResponse: Codable {
    let header: AttractionIntroInfoHeader
    let body: AttractionIntroInfoBody
}

struct AttractionIntroInfoHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

struct AttractionIntroInfoBody: Codable {
    let items: AttractionIntroInfoItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

struct AttractionIntroInfoItems: Codable {
    let item: [AttractionIntroInfoItem]
}

struct AttractionIntroInfoItem: Codable {
    let contentid: String
    let contenttypeid: String
    let heritage1: String
    let heritage2: String
    let heritage3: String
    let infocenter: String?
    let opendate: String?
    let restdate: String?
    let expguide: String?
    let expagerange: String
    let accomcount: String
    let useseason: String?
    let usetime: String?
    let parking: String?
    let chkbabycarriage: String
    let chkpet: String?
    let chkcreditcard: String
}

extension AttractionIntroInfoResponseResponse {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

extension AttractionIntroInfoResponse {
    enum CodingKeys: String, CodingKey {
        case header
        case body
    }
}


extension AttractionIntroInfoHeader {
    enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
}

extension AttractionIntroInfoBody {
    enum CodingKeys: String, CodingKey {
        case items
        case numOfRows
        case pageNo
        case totalCount
    }
}

extension AttractionIntroInfoItems {
    enum CodingKeys: String, CodingKey {
        case item
    }
}
