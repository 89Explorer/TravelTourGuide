//
//  ImageResponse.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/5/24.
//
import Foundation

// 최상위 응답 구조체
struct ImageResponseResponse: Codable {
    let response: ImageResponse
}

// 응답의 상위 구조체
struct ImageResponse: Codable {
    let header: ImageHeader
    let body: ImageBody
}

// 헤더 정보
struct ImageHeader: Codable {
    let resultCode: String
    let resultMsg: String
}

// 바디 구조체 (실제 데이터가 포함되는 부분)
struct ImageBody: Codable {
    let items: ImageItems
    let numOfRows: Int
    let pageNo: Int
    let totalCount: Int
}

// 아이템들을 포함하는 구조체
struct ImageItems: Codable {
    let item: [ImageItem]
}

// 각각의 이미지 정보를 포함하는 구조체
struct ImageItem: Codable {
    let contentid: String
    let originimgurl: String
    let imgname: String
    let smallimageurl: String
    let cpyrhtDivCd: String
    let serialnum: String
}

// CodingKeys를 사용하여 JSON의 키와 프로퍼티를 매핑
extension ImageResponseResponse {
    enum CodingKeys: String, CodingKey {
        case response
    }
}

extension ImageResponse {
    enum CodingKeys: String, CodingKey {
        case header
        case body
    }
}

extension ImageBody {
    enum CodingKeys: String, CodingKey {
        case items
        case numOfRows
        case pageNo
        case totalCount
    }
}

extension ImageItems {
    enum CodingKeys: String, CodingKey {
        case item
    }
}

extension ImageHeader {
    enum CodingKeys: String, CodingKey {
        case resultCode
        case resultMsg
    }
}
