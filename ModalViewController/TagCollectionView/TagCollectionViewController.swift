import UIKit

final class TagCollectionViewController: UIViewController {

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Стажировка в Surf"
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = Color.backgroundActiveDarkGray
        label.sizeToFit()
        return label
    }()

    private(set) lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: view.frame,
            collectionViewLayout: makeLayout()
        )
        collectionView.autoresizingMask = [
            .flexibleHeight,
            .flexibleWidth
        ]
        collectionView.backgroundColor = .systemBackground
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            TagSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(TagSectionHeader.self)"
        )
        collectionView.register(
            TagCollectionCell.self,
            forCellWithReuseIdentifier: "\(TagCollectionCell.self)"
        )
        return collectionView
    }()

    private var sections: [Section] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitleLabel()
        configureCollectionView()
        configureDataSource()
    }

    // MARK: - Private Helpers

    private func configureDataSource() {
        let horizontalScrollSectionItems = [
            TagViewModel(title: "iOS", state: Bool.random()),
            TagViewModel(title: "Android", state: Bool.random()),
            TagViewModel(title: "Design", state: Bool.random()),
            TagViewModel(title: "Flutter", state: Bool.random()),
            TagViewModel(title: "QA", state: Bool.random()),
            TagViewModel(title: "PM", state: Bool.random()),
            TagViewModel(title: "DevOps", state: Bool.random()),
            TagViewModel(title: "React", state: Bool.random()),
            TagViewModel(title: "Java", state: Bool.random()),
            TagViewModel(title: ".NET", state: Bool.random()),
            TagViewModel(title: "ML/AI", state: Bool.random()),
            TagViewModel(title: "Blockchain", state: Bool.random())
        ]
        let carouselSection = Section(
            id: 0,
            type: .carousel,
            title: "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты.",
            items: horizontalScrollSectionItems.dropLast(horizontalScrollSectionItems.count - 10)
        )

        let tagAreaSection = Section(
            id: 1,
            type: .tags,
            title: "Получай стипендию, выстраивай удобный график, работай на современном железе.",
            items: horizontalScrollSectionItems.dropLast(horizontalScrollSectionItems.count - 10)
        )
        sections = [
            carouselSection,
            tagAreaSection
        ]
    }

    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }


    var totalWidthPerRow = CGFloat(0)
    var rowCounts = 0
    let spaceBetweenCell = CGFloat(10) // whatever the space between each cell is

}

// MARK: - TagCollectionViewController+UICollectionViewDelegateFlowLayout

//extension TagCollectionViewController: UICollectionViewDelegateFlowLayout {
//
//    func collectionView(
//        _ collectionView: UICollectionView,
//        layout collectionViewLayout: UICollectionViewLayout,
//        sizeForItemAt indexPath: IndexPath
//    ) -> CGSize {
//        print("!!!!")
////        let collectionViewWidth = view.frame.width
////        let dynamicCellWidth = //whatever you calculate the width
////        totalWidthPerRow += dynamicCellWidth + spaceBetweenCell
////
////
////        if (totalWidthPerRow > collectionViewWidth) {
////            rowCounts += 1
////            totalWidthPerRow = dynamicCellWidth + spaceBetweenCell
////        }
//
//        return CGSizeMake(100 , CGFloat(30))//CGSizeMake(dynamicCellWidth , CGFloat(30))
//    }
//}
//public func reloadData() {
//    collectionView?.reloadData(withCompletion: {
//        // 첫 번째 아이템이 보이도록...
//        self.collectionView?.scrollToItem(at: IndexPath(item: self.cellIndexOfFirstItem, section: 0), at: .centeredHorizontally, animated: false)
//    })
//}
// MARK: - TagCollectionViewController+UICollectionViewDelegate

extension TagCollectionViewController: UICollectionViewDelegate {


//    private var cellIndexOfFirstItem: Int {
//        return 1
//    }
//
//    private var cellIndexOfLastItem: Int {
//        return sections[1].items.count
//    }

//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.item == cellIndexOfFirstItem {
//            if let leftCell = collectionView.cellForItem(at: IndexPath(item: cellIndexOfFirstItem-1, section: 0)), collectionView.bounds.contains(collectionView.convert(leftCell.center, to: collectionView)) {
//                let xOfCellOfLastItem = collectionView.contentSize.width-(cell.frame.width*2)
//                collectionView.contentOffset = CGPoint(x: xOfCellOfLastItem, y: 0)
//                // scrollToItem를 사용하면 빠르게 스와이프할 때 다음으로 연결이 안 되는 경우가 생길 수 있다.
//                // collectionView.scrollToItem(at: IndexPath(item: cellIndexOfLastItem, section: 0), at: .centeredHorizontally, animated: false)
//            }
//        } else if indexPath.item == cellIndexOfLastItem {
//            if let rightCell = collectionView.cellForItem(at: IndexPath(item: cellIndexOfLastItem+1, section: 0)), collectionView.bounds.contains(collectionView.convert(rightCell.center, to: collectionView)) {
//                let xOfCellOfFirstItem = cell.frame.width
//                collectionView.contentOffset = CGPoint(x: xOfCellOfFirstItem, y: 0)
//            }
//        }
//    }

//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        adjustDisplayCellCenter()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if decelerate == false {
//            adjustDisplayCellCenter()
//        }
//    }

    private func adjustDisplayCellCenter() {
        let cell = collectionView.visibleCells.filter { collectionView.bounds.contains(collectionView.convert($0.center, to: collectionView)) }.first
        if let cell = cell {
            let collectionViewCenter = collectionView.center
            let cellCenter = collectionView.convert(cell.center, to: collectionView.superview)
            let offsetX = collectionViewCenter.x - cellCenter.x
            if offsetX != 0 {
                collectionView.contentOffset = CGPoint(x: collectionView.contentOffset.x - offsetX, y: collectionView.contentOffset.y)
            }
        }
    }








    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionCell
        else {
            return
        }
        sections[indexPath.section].items[indexPath.row].state.toggle()
        cell.configure(sections[indexPath.section].items[indexPath.row])
        let cellSelected = sections[indexPath.section].items[indexPath.row].state
        if cellSelected {
            sections[indexPath.section].items.move(from: indexPath.row, to: .zero)
            let firstIndexPath = IndexPath(row: .zero, section: indexPath.section)
            collectionView.moveItem(at: indexPath, to: firstIndexPath)
        }
    }
}

// MARK: - TagCollectionViewController+UICollectionViewDataSource

extension TagCollectionViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        sections[section].items.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let viewModel = sections[indexPath.section].items[indexPath.item]
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "\(TagCollectionCell.self)",
                for: indexPath
            ) as? TagCollectionCell
        else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel)
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let sectionHeader = kind == UICollectionView.elementKindSectionHeader
        if sectionHeader {
            guard
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: "\(TagSectionHeader.self)",
                    for: indexPath
                ) as? TagSectionHeader
            else {
                return UICollectionReusableView()
            }
            let sectionHeaderText = sections[indexPath.section].title
            sectionHeader.setLabelText(sectionHeaderText)
            return sectionHeader
        } else {
            return UICollectionReusableView()
        }
    }
}

// MARK: - Collection Layout Factory

private extension TagCollectionViewController {

    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] index, env in
            guard let self = self else { return nil }
            let section = self.sections[index]
            switch section.type {
            case .single:
                return self.makeSingleSection()
            case .carousel:
                return self.makeCarouselSection()
            case .tags:
                return self.makeTagSection()
            default:
                return nil
            }
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }

    func makeSingleSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
        layoutGroup.interItemSpacing = .fixed(12)





        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.contentInsets = .init(top: 0, leading: 16, bottom: 0, trailing: 16)
        layoutSection.interGroupSpacing = 8




        return layoutSection
    }

    func makeCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(96),
            heightDimension: .estimated(36)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: itemSize.widthDimension,
            heightDimension: itemSize.heightDimension
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutGroupSize,
            subitems: [itemLayout]
        )

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .continuous
        layoutSection.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 20,
            bottom: .zero,
            trailing: 20
        )
        layoutSection.interGroupSpacing = 12

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(42)
        )
        let headerLayout = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        layoutSection.boundarySupplementaryItems = [headerLayout]
        return layoutSection
    }

    func makeTagSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .estimated(96),
            heightDimension: .estimated(36)
        )
        let itemLayout = NSCollectionLayoutItem(layoutSize: itemSize)

        let rowGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.heightDimension
        )
        let rowGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: rowGroupSize,
            subitems: [itemLayout]
        )
        rowGroup.interItemSpacing = .fixed(12)

        let columnGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let columnGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: columnGroupSize,
            repeatingSubitem: rowGroup,
            count: 2
        )
        columnGroup.interItemSpacing = .fixed(12)

        /*
        let layoutGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: itemSize.heightDimension
        )
        let layoutGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutGroupSize,
            subitems: [itemLayout]
        )
        layoutGroup.interItemSpacing = .fixed(12)
        */

        let layoutSection = NSCollectionLayoutSection(group: columnGroup)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(
            top: .zero,
            leading: 20,
            bottom: .zero,
            trailing: 20
        )
        layoutSection.interGroupSpacing = 12

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(42)
        )
        let headerLayout = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        layoutSection.boundarySupplementaryItems = [headerLayout]

        return layoutSection
    }
}
