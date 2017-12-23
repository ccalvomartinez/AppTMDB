//
//  ImageRepository.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 22/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

public protocol PImageRepositoryProtocol {
	func image(at path: String, size: ImageSize) -> Observable<UIImage>
}

internal protocol PImageManager {
	func image(withURL url: URL) -> Observable<UIImage>
}

final internal class ImageRepository: PImageRepositoryProtocol {
	private let baseURL: Observable<URL>
	private let imageManager: PImageManager

	init(webService: WebService, imageManager: PImageManager) {
		self.baseURL = webService.load(Configuration.self, from: .configuration)
			.catchErrorJustReturn(.default)
			.map { $0.images.baseURL }
			.share(replay: 1)
		self.imageManager = imageManager
	}

	func image(at path: String, size: ImageSize) -> Observable<UIImage> {
		let imageManager = self.imageManager

		return baseURL
			.map { $0.appendingPathComponent(size.rawValue).appendingPathComponent(path) }
			.flatMap { imageManager.image(withURL: $0) }
	}
}

extension KingfisherManager: PImageManager {
	func image(withURL url: URL) -> Observable<UIImage> {
		return Observable.create { observer in
			let task = self.retrieveImage(
				with: ImageResource(downloadURL: url),
				options: nil,
				progressBlock: nil
			) { image, error, _, _ in
				if let error = error {
					observer.onError(error)
				} else {
					observer.onNext(image ?? UIImage())
					observer.onCompleted()
				}
			}

			return Disposables.create {
				task.cancel()
			}
		}
	}
}
