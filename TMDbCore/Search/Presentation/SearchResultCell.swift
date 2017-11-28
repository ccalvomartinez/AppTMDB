import UIKit
import RxSwift

final class SearchResultCell: UITableViewCell, PReusableView, PNibLoadableView {
	// MARK: - Outlets

	@IBOutlet var posterView: UIImageView!
	@IBOutlet var headlineLabel: UILabel!
	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var metadataLabel: UILabel!

	// MARK: - Properties

	private(set) var disposeBag = DisposeBag()

	// MARK: - Overrides

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()
	}
}
