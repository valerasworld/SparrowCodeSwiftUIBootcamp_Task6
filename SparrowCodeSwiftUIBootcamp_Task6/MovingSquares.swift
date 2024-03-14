//
//  MovingSquares.swift
//  SparrowCodeSwiftUIBootcamp_Task6
//
//  Created by Валерий Зазулин on 14.03.2024.
//

import SwiftUI

struct MovingSquares: View {
    
    let quantity: Int = 9
    let spacing: CGFloat = 10
    @State var isDiagonalMode: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            let squareHeight = (geo.size.width - (spacing * CGFloat(quantity) - 1)) / CGFloat(quantity)
            let bigSquareWidth = geo.size.height / CGFloat(quantity)
            
            HStack(spacing: isDiagonalMode ? spacing : ((geo.size.width - bigSquareWidth * CGFloat(quantity)) / CGFloat(quantity - 1))) {
                ForEach(0..<quantity) { index in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.blue)
                        .frame(
                            width: isDiagonalMode ? squareHeight : geo.size.height / CGFloat(quantity),
                            height: isDiagonalMode ? squareHeight : geo.size.height / CGFloat(quantity)
                        )
                        .offset(
                            y: isDiagonalMode ? 0 :
                                (
                                    quantity % 2 == 0 ?
                                    -bigSquareWidth / 2 + bigSquareWidth * -findOffsetMultiplier(quantity: quantity, index: index) :
                                        bigSquareWidth * -findOffsetMultiplier(quantity: quantity, index: index)
                                )
                    )
                        .onTapGesture {
                            withAnimation {
                                isDiagonalMode.toggle()
                            }
                        }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        
        }
        .padding()
        
        
    }
    
    func findOffsetMultiplier(quantity: Int, index: Int) -> CGFloat {
        let middleIndex = (quantity + 1) / 2
        
        let distance = index - middleIndex + 1
        
        if quantity % 2 == 0 {
            return CGFloat(-middleIndex + index)
        } else {
            return CGFloat(distance)
        }
    }
}

#Preview {
    MovingSquares()
}
