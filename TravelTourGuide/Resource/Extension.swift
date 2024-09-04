//
//  Extension.swift
//  TravelTourGuide
//
//  Created by 권정근 on 9/4/24.
//

import Foundation

// MARK: - 문자열에서 괄호와 괄호 안에 내용을 제거 
extension String {
    func removingParentheses() -> String {
        return self.replacingOccurrences(of: "\\s*[\\(\\[].*?[\\)\\]]", with: "", options: .regularExpression)
    }
}
/*
 \\s* : 괄호 앞의 공백을 포함한 공백 문자들을 선택적으로 제거합니다.
 [\\(\\[] : ( 또는 [ 문자를 찾습니다.
 .*? : 괄호 안의 모든 문자들을 매칭합니다.
 [\\)\\]] : ) 또는 ] 문자를 찾습니다.
 */
