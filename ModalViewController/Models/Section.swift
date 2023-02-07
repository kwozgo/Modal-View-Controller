enum SectionType: Int, CaseIterable {
    case single
    case double
    case carousel
    case tags
}

struct Section {
    let id: Int
    let type: SectionType
    let title: String?
    var items: [TagViewModel]
}
