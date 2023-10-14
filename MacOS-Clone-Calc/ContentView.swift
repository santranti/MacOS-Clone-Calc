//
//                  MacOS-Clone-Calc
//                  ContentView.swift
//                  Made by Santranti
//


import SwiftUI

struct ContentView: View {
    @State private var displayText: String = "0"
    @State private var firstOperand: Double? = nil
    @State private var operation: String? = nil
    
    let buttonBackground = Color(red: 224/255, green: 224/255, blue: 224/255)
    let operationBackground = Color(red: 255/255, green: 159/255, blue: 10/255)
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            // Display
            HStack {
                Text(displayText)
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.bottom, 30)

            // Buttons
            VStack(spacing: 12) {
                ForEach(0..<5) { rowIndex in
                    HStack(spacing: 12) {
                        ForEach(0..<4) { colIndex in
                            Button(action: {
                                self.handleButtonPress(label: self.buttonLabel(row: rowIndex, col: colIndex))
                            }) {
                                Text(buttonLabel(row: rowIndex, col: colIndex))
                                    .font(.system(size: 28))
                                    .frame(width: 80, height: 80)
                                    .background(self.buttonColor(row: rowIndex, col: colIndex))
                                    .cornerRadius(40)
                                    .foregroundColor(self.buttonTextColor(row: rowIndex, col: colIndex))
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
        }
        .background(Color.black)
        .padding()
    }

    func buttonLabel(row: Int, col: Int) -> String {
        let labels = [
            ["AC", "DEL", "%", "/"],
            ["7", "8", "9", "x"],
            ["4", "5", "6", "-"],
            ["1", "2", "3", "+"],
            ["0", ".", "=", ""]
        ]
        return labels[row][col]
    }

    func buttonColor(row: Int, col: Int) -> Color {
        let operations = ["+", "-", "x", "/", "="]
        if operations.contains(buttonLabel(row: row, col: col)) {
            return operationBackground
        } else if row == 0 {
            return Color.gray
        } else {
            return buttonBackground
        }
    }
    
    func buttonTextColor(row: Int, col: Int) -> Color {
        let operations = ["+", "-", "x", "/", "="]
        if operations.contains(buttonLabel(row: row, col: col)) || row == 0 {
            return .white
        } else {
            return .black
        }
    }
    
    func handleButtonPress(label: String) {
        if "0123456789.".contains(label) {
            if displayText == "0" && label != "." {
                displayText = label
            } else {
                displayText += label
            }
        } else {
            switch label {
            case "+", "-", "x", "/":
                if firstOperand == nil {
                    firstOperand = Double(displayText)
                    displayText += label
                    operation = label
                } else {
                    displayText += label
                    operation = label
                }
            case "=":
                let components = displayText.split(separator: operation!.first!)
                if components.count == 2,
                   let firstOp = Double(components[0]),
                   let secondOp = Double(components[1]) {
                    switch operation {
                    case "+":
                        displayText = "\(firstOp + secondOp)"
                    case "-":
                        displayText = "\(firstOp - secondOp)"
                    case "x":
                        displayText = "\(firstOp * secondOp)"
                    case "/":
                        displayText = "\(firstOp / secondOp)"
                    default:
                        break
                    }
                }
                firstOperand = nil
                operation = nil
            case "AC":
                displayText = "0"
                firstOperand = nil
                operation = nil
            case "DEL":
                if !displayText.isEmpty {
                    displayText.removeLast()
                }
                if displayText.isEmpty {
                    displayText = "0"
                }
            default:
                break
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
