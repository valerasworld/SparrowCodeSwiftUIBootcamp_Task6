//
//  MovingSquares.swift
//  SparrowCodeSwiftUIBootcamp_Task6
//
//  Created by Валерий Зазулин on 14.03.2024.
//

import SwiftUI

struct MovingSquares: View {
    
    let quantity: CGFloat = 8
    let spacing: CGFloat = 10
    @State var isDiagonal: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            let squareHeight = (geo.size.width - (spacing * (quantity - 1))) / quantity
            let bigSquareWidthAndHeight = geo.size.height / quantity
            let newSpacing = (geo.size.width - bigSquareWidthAndHeight * quantity) / (quantity - 1)
            let isEven = Int(quantity) % 2 == 0
            
                HStack(spacing: isDiagonal ? spacing : newSpacing) {
                    ForEach(0..<Int(quantity), id: \.self) { index in
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.blue)
                            .frame(
                                width: isDiagonal ? squareHeight : bigSquareWidthAndHeight,
                                height: isDiagonal ? squareHeight : bigSquareWidthAndHeight
                            )
                            .offset(y: isDiagonal ? 0 :
                                    findOffset(quantity: quantity,
                                               index: index,
                                               isEven: isEven,
                                               bigSquareWidthAndHeight: bigSquareWidthAndHeight)
                            )
                            .onTapGesture {
                                withAnimation {
                                    isDiagonal.toggle()
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func findOffset(quantity: CGFloat, index: Int, isEven: Bool, bigSquareWidthAndHeight: CGFloat) -> CGFloat {
        let middleIndex = (Int(quantity) + 1) / 2
        let distance = index - middleIndex + 1
        
        if isEven {
            return -bigSquareWidthAndHeight / 2 + bigSquareWidthAndHeight * -CGFloat(-middleIndex + index)
        } else {
            return bigSquareWidthAndHeight * -CGFloat(distance)
        }
    }
}

#Preview {
    MovingSquares()
}
