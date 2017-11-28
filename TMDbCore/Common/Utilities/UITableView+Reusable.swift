import UIKit

extension UITableView {
	func register<T: UITableViewCell>(_: T.Type) where T: PReusableView {
		register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	func register<T: UITableViewCell>(_: T.Type) where T: PReusableView, T: PNibLoadableView {
		let bundle = Bundle(for: T.self)
		let nib = UINib(nibName: T.nibName, bundle: bundle)

		register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type) -> T where T: PReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}

		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: PReusableView {
		guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
			fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
		}
		
		return cell
	}

	func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for row: Int) -> T where T: PReusableView {
		return dequeueReusableCell(T.self, for: IndexPath(row: row, section: 0))
	}
}
