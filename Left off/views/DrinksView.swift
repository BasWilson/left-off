//
//  DrinksView.swift
//  Left off
//
//  Created by Bas Wilson on 15/12/2023.
//

import SwiftUI
import SwiftData

struct DrinksView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DrinkDay.timestamp, order: .forward) private var drinks: [DrinkDay]
    
    var formatter = DateFormatter()
    var measFormatter = MeasurementFormatter()
    @State var activeDay: String?
    
    init() {
        self.formatter.dateStyle = .short
        self.activeDay = self.formatter.string(from: Date())
        self.measFormatter.numberFormatter.maximumFractionDigits = 2
    }
    
    func addWaterToDay(type: DrinkType, amount: Double) -> Void {
        
        var today = drinks.first { drink in
            return drink.date == self.activeDay
        }
        
        if (today == nil) {
            let day = DrinkDay(timestamp: Date())
            modelContext.insert(day)
        }
        
        today = drinks.first { drink in
            return drink.date == self.activeDay
        }
                
        today?.addDrink(amount: amount, type: type)
    }
    
    var body: some View {
        ScrollView {
            HStack {
                
                let today = drinks.first { drink in
                    return drink.date == activeDay
                }
                
                let waterAmount = today?.waterAmount ?? 0.0
                let coffeeAmount = today?.coffeeAmount ?? 0.0
                let sodaAmount = today?.sodaAmount ?? 0.0
            
                
                // Water
                VStack {

                    let volume = Measurement(value: waterAmount, unit: UnitVolume.milliliters)
                    
                    Text("Water")
                        .lineLimit(0)

                    Image(systemName: "waterbottle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    
                    Text(self.measFormatter.string(from: volume))
                        .font(.largeTitle)
                        .lineLimit(0)

                    HStack {
                        Button(action: {
                            addWaterToDay(type: .water, amount: -100)
                        }, label: {
                            Image(systemName:  "minus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.orange)
                        })
                        Button(action: {
                            addWaterToDay(type: .water, amount: 100)
                        }, label: {
                            Image(systemName:  "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)

                        })
                    }
                }
                .frame(maxWidth: .infinity)
                
                
                // Coffee
                VStack {

                    let volume = Measurement(value: coffeeAmount, unit: UnitVolume.milliliters)
                    
                    Text("Coffee")
                        .lineLimit(0)

                    Image(systemName: "mug.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    
                    Text(self.measFormatter.string(from: volume))
                        .font(.largeTitle)
                        .lineLimit(0)
                    
                    HStack {
                        Button(action: {
                            addWaterToDay(type: .coffee, amount: -100)
                        }, label: {
                            Image(systemName:  "minus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.orange)
                        })
                        Button(action: {
                            addWaterToDay(type: .coffee, amount: 100)
                        }, label: {
                            Image(systemName:  "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)

                        })
                    }
         
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                
                // Soda
                VStack {

                    let volume = Measurement(value: sodaAmount, unit: UnitVolume.milliliters)
                    
                    Text("Soda")
                        .lineLimit(0)

                    Image(systemName: "takeoutbag.and.cup.and.straw.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                    
                    Text(self.measFormatter.string(from: volume))
                        .font(.largeTitle)
                        .lineLimit(0)

                    HStack {
                        Button(action: {
                            addWaterToDay(type: .soda, amount: -100)
                        }, label: {
                            Image(systemName:  "minus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.orange)
                        })
                        Button(action: {
                            addWaterToDay(type: .soda, amount: 100)
                        }, label: {
                            Image(systemName:  "plus.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)

                        })
                    }
                }
                .frame(maxWidth: .infinity)

            }
            .padding(.horizontal)
        }
        .onAppear {
            if (self.activeDay == nil) {
                self.activeDay = self.formatter.string(from: Date())
            }
            
            self.measFormatter.numberFormatter.maximumFractionDigits = 2

        }
        .navigationTitle("Drinks")
    }
}

#Preview {
    DrinksView()
}
