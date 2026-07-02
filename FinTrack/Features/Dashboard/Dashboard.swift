//
//  Dashboard.swift
//  FinTrack
//
//  Created by Anjan Tewani on 26/12/25.
//

import SwiftUI

struct Dashboard: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppSpacing.sm) {
                
                
                VStack(alignment: .leading) {
                    Text("Total Amount")
                        .font(AppTypography.body)
                        .foregroundStyle(.secondary)
                    
                    Text("₹ \(dashboardViewModel.totalAmount, specifier: "%.2f")")
                        .font(AppTypography.title)
                        .foregroundStyle(AppColors.accentPrimary)
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.top, AppSpacing.sm)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(AppColors.cardBackground.opacity(0.7))
                .cornerRadius(AppSpacing.md)
                .padding(.top, AppSpacing.md)

                
                VStack(alignment: .leading) {
                    Text("Recent Expenses")
                        .font(AppTypography.body)
                        .foregroundStyle(.secondary)
                    
                    if dashboardViewModel.recentExpenses.isEmpty {
                        Text("No recent expenses")
                            .font(AppTypography.subtitle)
                            .padding(.horizontal, AppSpacing.md)
                            .padding(.top, AppSpacing.sm)
                    } else {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            ForEach(dashboardViewModel.recentExpenses) { recentExpense in
                                RecentExpenseRowView(expense: recentExpense)
                                    .padding(.horizontal, AppSpacing.sm)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, AppSpacing.lg)
                
                
                VStack(alignment: .leading) {
                    Text("Category Breakdown")
                        .font(AppTypography.body)
                        .foregroundStyle(.secondary)
                    
                    if dashboardViewModel.categoryTotals.isEmpty {
                        Text("No category data")
                            .font(AppTypography.body)
                            .padding(.horizontal, AppSpacing.md)
                            .padding(.top, AppSpacing.sm)
                    } else {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            ForEach(dashboardViewModel.categoryTotals.sorted { $0.value > $1.value }, id: \.key) { categoryTotal in
                                CategoryTotalRowView(category: categoryTotal.key, totalAmount: categoryTotal.value)
                                    .padding(.horizontal, AppSpacing.md)
                                    
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, AppSpacing.lg)


                VStack(alignment: .leading) {
                    Text("Category Charts")
                        .font(AppTypography.body)
                        .foregroundStyle(.secondary)
                    
                    if dashboardViewModel.categoryChartData.isEmpty {
                        Text("No Category data")
                            .font(AppTypography.body)
                            .padding(.horizontal, AppSpacing.md)
                            .padding(.top, AppSpacing.sm)
                    } else {
                        VStack(alignment: .leading, spacing: AppSpacing.sm) {
                            ForEach(dashboardViewModel.categoryChartData, id: \.self) { categorChartData in
                                BarChartRowView(icon: categorChartData.category.icon, category: categorChartData.category.title, amount: categorChartData.amount, percentage: categorChartData.percentage)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, AppSpacing.lg)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, AppSpacing.sm)
            .padding(.horizontal, AppSpacing.md)
        }
    }
}

//#Preview {
//    Dashboard()
//}
