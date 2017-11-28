//
//  PhoneDetailNavigator.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 07/10/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

final class PhoneDetailNavigator: PDetailNavigator {
	private let navigationController: UINavigationController
	private unowned let viewControllerProvider: PDetailViewControllerProvider

	init(navigationController: UINavigationController,
	     viewControllerProvider: PDetailViewControllerProvider) {
		self.navigationController = navigationController
		self.viewControllerProvider = viewControllerProvider
	}

	func showDetail(withIdentifier identifier: Int64, mediaType: MediaType) {
		let viewController = viewControllerProvider.detailViewController(identifier: identifier, mediaType: mediaType)
		navigationController.pushViewController(viewController, animated: true)
	}
}
