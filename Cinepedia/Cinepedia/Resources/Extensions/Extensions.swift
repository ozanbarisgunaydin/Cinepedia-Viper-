//
//  Extensions.swift
//  Cinepedia
//
//  Created by Ozan Barış Günaydın on 24.04.2022.
//

import UIKit

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}

//MARK: - UITableView
public extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

//MARK: - UICollectionView
public extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

//MARK: - Arrays
public extension Collection where Indices.Iterator.Element == Index {
  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

//MARK: - Date
public extension String {
    func convertDateFormat(inputDate: String) -> String {

         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let oldDate = dateFormatter.date(from: inputDate) else { return "00.00.0000" }

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "MM.dd.yyyy"

         return convertDateFormatter.string(from: oldDate)
    }
}

//MARK: - UIApplication
public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter({
                $0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
        
        let window = connectedScenes.first?
            .windows
            .first { $0.isKeyWindow }

        return window
        
    }
}
