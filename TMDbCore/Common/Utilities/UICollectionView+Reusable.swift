import UIKit

extension UICollectionView {
	func register<T: UICollectionViewCell>(_: T.Type) where T: PReusableView {
		register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}

	func register<T: UICollectionViewCell>(_: T.Type) where T: PReusableView, T: PNibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)

		register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
	}

	func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: PReusableView {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for item: Int) -> T where T: PReusableView {
		return dequeueReusableCell(T.self, for: IndexPath(item: item, section: 0))
	}
}
