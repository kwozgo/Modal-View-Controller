extension Array where Element: Equatable {

    mutating func move(_ element: Element, to newIndex: Index) {
        if let oldIndex: Int = firstIndex(of: element) {
            move(from: oldIndex, to: newIndex)
        }
    }
}

extension Array {

    mutating func move(from oldIndex: Index, to newIndex: Index) {
        if oldIndex == newIndex { return }
        if abs(newIndex - oldIndex) == 1 {
            swapAt(oldIndex, newIndex)
        }
        insert(remove(at: oldIndex), at: newIndex)
    }
}
