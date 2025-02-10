//
//  PhotoDetailViewModel.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 2/10/25.
//

import Foundation

final class PhotoDetailViewModel: BaseViewModel {
    
    // MARK: - properties
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let triggeredViewDidLoad: Observable<Photo?> = Observable(nil)
    }
    
    struct Output {
        let photo: Observable<Photo?> = Observable(nil)
        let photoStatistic: Observable<PhotoStatistic?> = Observable(nil)
    }
    
    // MARK: - life cycles
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    // MARK: - methods
    func transform() {
        input.triggeredViewDidLoad.lazyBind { [weak self] photo in
            self?.output.photo.value = photo
            self?.fetchPhotoStatistic(photoId: photo?.id)
        }
    }
    
    private func fetchPhotoStatistic(photoId: String?) {
        guard let photoId else {
            output.photoStatistic.value = nil
            return
        }
        
        NetworkManager.shared.request(PhotoStatistic.self, router: .fetchPhotoStatistic(photoId: photoId)) { [weak self] result in
            switch result {
            case .success(let photoStatistic):
                self?.output.photoStatistic.value = photoStatistic
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
