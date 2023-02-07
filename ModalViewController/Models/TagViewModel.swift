import UIKit

struct TagViewModel {
    let title: String
    var state: Bool
}

extension TagViewModel {

    var backgroundColor: UIColor {
        state ? Color.backgroundActiveDarkGray : Color.backgroundInactiveGray
    }

    var titleColor: UIColor {
        state ? .white : Color.backgroundActiveDarkGray
    }
}
