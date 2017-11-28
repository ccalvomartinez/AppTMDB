import UIKit

protocol PNibLoadableView: class {
	static var nibName: String { get }
	static func instantiate() -> Self
}

extension PNibLoadableView where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}

	static func instantiate() -> Self {
		return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
			.instantiate(withOwner: nil, options: nil)[0] as! Self
	}
}
