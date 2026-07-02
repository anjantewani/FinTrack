//
//  Expenses.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Expenses: View {
    @ObservedObject var expensesViewModel: ExpensesViewModel
    @State var showAddExpense: Bool = false
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddExpense = true
                    } label: {
                        Text("Add Expense")
                    }
                }
            }
            .sheet(isPresented: $showAddExpense) {
                NavigationStack {
                    AddExpenseView(expensesViewModel: expensesViewModel)
                        .navigationTitle("Add Expense")
                }
            }
    }
    
    @ViewBuilder
    var content: some View {
        switch expensesViewModel.state {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(2)
            
        case .empty:
            EmptyStateView(title: "No Expenses", description: "You have no expenses yet.", action: {})
            
        case .loaded:
            VStack {
                HStack {
                    ScrollView(.horizontal) {
                        HStack(alignment: .center, spacing: AppSpacing.sm) {
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    expensesViewModel.selectedCategory = nil
                                }
                            } label: {
                                Text("All")
                            }
                            .padding(.vertical, AppSpacing.sm)
                            .padding(.horizontal, AppSpacing.lg)
                            .background(expensesViewModel.selectedCategory == nil ? AppColors.accentPrimary : .clear)
                            .foregroundStyle(expensesViewModel.selectedCategory == nil ? AppColors.textOnAccentPrimary : AppColors.accentPrimary)
                            .overlay(
                                RoundedRectangle(cornerRadius: AppSpacing.lg)
                                    .stroke(AppColors.accentPrimary)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: AppSpacing.lg))
                            
                            
                            ForEach(ExpenseCategory.allCases, id: \.self) { category in
                                Button {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        expensesViewModel.selectedCategory = category
                                    }
                                } label: {
                                    Text(category.title)
                                }
                                .padding(.vertical, AppSpacing.sm)
                                .padding(.horizontal, AppSpacing.lg)
                                .background(expensesViewModel.selectedCategory == category ? AppColors.accentPrimary : .clear)
                                .foregroundStyle(expensesViewModel.selectedCategory == category ? AppColors.textOnAccentPrimary : AppColors.accentPrimary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AppSpacing.lg)
                                        .stroke(AppColors.accentPrimary)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: AppSpacing.lg))
                            }
                        }
                    }
                    .scrollIndicators(.never)
                    
                    Divider()
                        .frame(height: 40)
                        .padding(.leading, AppSpacing.xs)
                        .padding(.trailing, AppSpacing.xs)
                    
                    Menu {
                        ForEach(SortOption.allCases, id: \.self)  { sort in
                            Button {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.expensesViewModel.selectedSortOption = sort
                                }
                            } label: {
                                Text(sort.title)
                            }
                        }
                    } label: {
                        HStack {
                            Text("Sort: ")
                                .foregroundStyle(.secondary)
                            Text(expensesViewModel.selectedSortOption.titleShorthand)
                        }
                    }
                }
                .padding(.vertical, AppSpacing.lg)
                .padding(.horizontal, AppSpacing.lg)
                
                List {
                    ForEach(expensesViewModel.sortedExpenses) { expense in
                        NavigationLink {
                            ExpenseDetailView(expense: expense)
                        } label: {
                            ExpenseRowView(expense: expense)
                        }
                    }
                    .onDelete(perform: { indexes in
                        expensesViewModel.deleteExpenses(withIndexes: indexes)
                    })
                }
            }
            
        case .error:
            EmptyStateView() {
                Button {
                    expensesViewModel.loadExpenses()
                } label: {
                    Text("Retry")
                }
            }
        }
    }
}

//#Preview {
//    Expenses()
//}
