import UIKit

protocol PReusableView: class {
	static var defaultReuseIdentifier: String { get }
}

extension PReusableView where Self: UIView {

	static var defaultReuseIdentifier: String {
		return String(describing: self)
	}
}
