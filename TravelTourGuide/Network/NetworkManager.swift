//
//  NetworkManager.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/4/24.
//

import Foundation


// MARK: - Constants
struct Constants {
    static let api_key = "jlK%2B0ig7iLAbdOuTJsnkp6n0RdeEMtGKsw53jEMbKm3PcB7NFTSeUrnXixogiuvNtHQXeqxgV88buRZvTjG73w%3D%3D"
    static let base_URL = "https://apis.data.go.kr/B551011/KorService1"
}



// MARK: - NetworkManager 수정
class NetworkManager {
    static let shared = NetworkManager()
    
    
    // 홈화면에서 전지역을 상대로 검색하는 함수 ㅌ
    func getCommonData(contentTypeId: String, pageNo: String = "1", completion: @escaping (Result<AttractionResponse, Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/areaBasedList1")
        
        // 쿼리 아이템 설정
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: pageNo),
            URLQueryItem(name: "MobileOS", value: "ETC"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "listYN", value: "Y"),
            URLQueryItem(name: "arrange", value: "O"),
            URLQueryItem(name: "contentTypeId", value: contentTypeId)
        ]
        
        // 퍼센트 인코딩 후 "+"를 "%2B"로 대체
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성
        guard let url = components?.url else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(AttractionResponse.self, from: data)
                completion(.success(results))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    // 받아온 데이터에서 전체 페이지 수를 구한 다음, 페이지를 랜덤으로 선정하여 데이터를 가져오는 함수
    func fetchRandomPageData(contentTypeId: String, completion: @escaping (Result<[Item], Error>) -> Void) {
        // 1페이지 데이터를 먼저 가져와 전체 페이지 수를 계산
        getCommonData(contentTypeId: contentTypeId, pageNo: "1") { result in
            switch result {
            case .success(let response):
                let totalCount = response.response.body.totalCount
                let numOfRows = response.response.body.numOfRows
                let totalPages = (totalCount + numOfRows - 1) / numOfRows
                
                // 전체 페이지 수 내에서 무작위로 페이지 선택
                let randomPage = Int.random(in: 1...totalPages)
                
                // 선택된 페이지 데이터 가져오기
                self.getCommonData(contentTypeId: contentTypeId, pageNo: "\(randomPage)") { result in
                    switch result {
                    case .success(let response):
                        completion(.success(response.response.body.items.item))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    // 상세 이미지 갖고 오는 함수
    func getImageData(contentId: String, completion: @escaping (Result<ImageItems, Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/detailImage1?")
        
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "MobileOS", value: "ETC"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId),
            URLQueryItem(name: "imageYN", value: "Y"),
            URLQueryItem(name: "subImageYN", value: "Y"),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1")
        ]
        
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        guard let url = components?.url else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                // AttractionResponse로 JSON 디코딩
                let results = try JSONDecoder().decode(ImageResponseResponse.self, from: data)
                
                // completion handler로 결과 반환
                completion(.success(results.response.body.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    // 상세 소개 정보를 가져오는 함수
    func getIntroInfoData(contentId: String, contentTypeId: String, completion: @escaping (Result<AttractionIntroInfoItems, Error>) -> Void) {
        var components = URLComponents(string: "\(Constants.base_URL)/detailIntro1?")
        
        components?.queryItems = [
            URLQueryItem(name: "serviceKey", value: Constants.api_key),
            URLQueryItem(name: "MobileOS", value: "ETC"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "_type", value: "json"),
            URLQueryItem(name: "contentId", value: contentId),
            URLQueryItem(name: "contentTypeId", value: contentTypeId),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "pageNo", value: "1")
        ]
        
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        guard let url = components?.url else { return }

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                // AttractionResponse로 JSON 디코딩
                let results = try JSONDecoder().decode(AttractionIntroInfoResponseResponse.self, from: data)
                
                // completion handler로 결과 반환
                completion(.success(results.response.body.items))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // 지역 기반 리스트 데이터를 가져오는 함수
    func getAreaBasedList(completion: @escaping (Result<AttractionResponse, Error>) -> Void) {
        var components = URLComponents(string: "https://apis.data.go.kr/B551011/KorService1/areaBasedList1?")
        
        components?.queryItems = [
            URLQueryItem(name: "numOfRows", value: "12"),
            URLQueryItem(name: "pageNo", value: "1"),
            URLQueryItem(name: "MobileOS", value: "ETC"),
            URLQueryItem(name: "MobileApp", value: "AppTest"),
            URLQueryItem(name: "ServiceKey", value: "jlK%2B0ig7iLAbdOuTJsnkp6n0RdeEMtGKsw53jEMbKm3PcB7NFTSeUrnXixogiuvNtHQXeqxgV88buRZvTjG73w%3D%3D"),
            URLQueryItem(name: "listYN", value: "Y"),
            URLQueryItem(name: "arrange", value: "O"),
            URLQueryItem(name: "contentTypeId", value: "12"),
            URLQueryItem(name: "areaCode", value: ""),
            URLQueryItem(name: "sigunguCode", value: ""),
            URLQueryItem(name: "cat1", value: "A01"),
            URLQueryItem(name: "cat2", value: "A0101"),
            URLQueryItem(name: "cat3", value: "A01010100"),
            URLQueryItem(name: "_type", value: "json")
        ]
        
        if let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "%25", with: "%") {
            components?.percentEncodedQuery = encodedQuery
        }
        
        // URL 생성 및 요청
        guard let url = components?.url else { return }
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            do {
                // JSON 디코딩
                let results = try JSONDecoder().decode(AttractionResponse.self, from: data)
                // 성공 시 결과 반환
                print(results)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
