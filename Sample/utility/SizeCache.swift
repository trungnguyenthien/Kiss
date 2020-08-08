//
//  SizeCache.swift
//  Sample
//
//  Created by Trung on 8/8/20.
//  Copyright © 2020 trungnguyenthien. All rights reserved.
//

import Foundation

/// Class hỗ trợ lưu kết quả sau khi tính toán ứng với từng Model.
/// Chúng tôi recommend nên define Model là 1 Hashable, Model chứa các field ảnh hưởng đến quá trình tính toán.
class ValueCache<M: Hashable, V: Hashable> {
    private var memCache = [M: V]()
    typealias Calculation = (M) -> V
    private let calculationBlock: Calculation
    
    init(calculation: @escaping Calculation) {
        self.calculationBlock = calculation
    }
    
    /// xóa tất cả cache
    func clear() {
        memCache.removeAll()
    }
    
    /// Cache trước khi có nhu cầu sử dụng
    /// - Parameters:
    ///   - model: model data dùng để xác định value
    func prepare(for model: M) {
        if !memCache.keys.contains(model) {
            memCache[model] = calculationBlock(model)
        }
    }
    
    /// Get value, nếu chưa được cache thì sẽ đi
    /// - Parameters:
    ///   - model: model data dùng để xác định value
    /// - Returns: Value tương ứng với Model
    func value(for model: M) -> V {
        prepare(for: model)
        return memCache[model]!
    }
}
