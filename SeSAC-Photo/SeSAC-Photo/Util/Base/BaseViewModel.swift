//
//  BaseViewModel.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 2/10/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform()
}
