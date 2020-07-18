//
//  SUICell.swift
//  Sample
//
//  Created by Trung on 7/18/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import SwiftUI
extension UIView {
    func add<T: View>(hosting: UIHostingController<T>) {
        addSubview(hosting.view)
    }
}

struct SUICell: View {
    @State var name = "Trung Nguyen"
    @State var email = "ngthientrung@gmail.com"
    
    func update(name: String, email: String) {
        print(" update(name: \(name), email: \(email)")
        self.email = email
        self.name = name
    }
    
    var body: some View {
        VStack {
            Text(name).foregroundColor(.pink).fontWeight(.heavy)
            Text(email)
        }.padding(10).background(Color.yellow)
        
    }
}

class UIKitCell: UICollectionViewCell, UIViewRepresentable {
    typealias UIViewType = SUICell
    
    let hosting = UIHostingController(rootView: SUICell())
    
    var mainCell: SUICell {
        return hosting.rootView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    init() {
        super.init(frame: .zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        add(hosting: hosting)
    }
    
    func update(name: String, email: String) {
        mainCell.update(name: name, email: email)
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hosting.view.frame = self.bounds
        print("self.frame = \(self.bounds)")
//        mainCell.frame(width: self.bounds.width, height: self.bounds.height, alignment: .center)
//        hosting.view.layoutIfNeeded()
    }
    
    func size(hardWidth: Double) -> CGSize {
        let output = hosting.sizeThatFits(in: CGSize(width: Int(hardWidth), height: Int.max))
        print("output = \(output)")
        return output
    }
}

struct SUICell_Previews: PreviewProvider {
    static var previews: some View {
        SUICell()
    }
}
