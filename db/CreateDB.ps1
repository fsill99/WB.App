function executeSql([string]$pathSql) {
    sqlcmd -s localhost -U sa -P 'pa$$w0rd' -i $pathSql
}

# Create table
executeSql '.\WB.Init.sql'

# Create Views
executeSql '.\Views\WB.ActionViews.sql'
executeSql '.\Views\WB.UserViews.sql'

# Create currency udf
executeSql '.\UDF\WB.udf_GetCurrencyId.sql'

# Create action udf
executeSql '.\UDF\WB.udf_GetOrderedAction.sql'

# Create currency Stored Procedures
executeSql '.\StoredProcedures\SPU.Currency\WB.spu_AddCurrency.sql'
executeSql '.\StoredProcedures\SPU.Currency\WB.spu_UpdateCurrency.sql'
executeSql '.\StoredProcedures\SPU.Currency\WB.spu_DeleteCurrencyPerm.sql'
executeSql '.\StoredProcedures\SPU.Currency\WB.spu_GetAllCurrency.sql'

# Run Currency Seed
# executeSql '.\Seed\WB.Currency.sql'

# Create ActionCategory Stored Procedures
executeSql '.\StoredProcedures\SPU.ActionCategory\WB.spu_AddCategory.sql'
executeSql '.\StoredProcedures\SPU.ActionCategory\WB.spu_GetCateroryActionId.sql'
executeSql '.\StoredProcedures\SPU.ActionCategory\WB.spu_GetAllCategory.sql'
executeSql '.\StoredProcedures\SPU.ActionCategory\WB.spu_UpdateCategory.sql'
executeSql '.\StoredProcedures\SPU.ActionCategory\WB.spu_DeleteCategoryPerm.sql'

# Create User Stored Procedures
executeSql '.\StoredProcedures\SPU.User\WB.spu_SubmitUser.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_GetUserIdByUsername.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_ExpireUser.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_UnexpireUser.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_DeleteUserPerm.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_UpdateUserInfo.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_ChangeUserPassword.sql'
executeSql '.\StoredProcedures\SPU.User\WB.spu_LoginUser.sql'


# Create Action Stored procedures
executeSql '.\StoredProcedures\SPU.Action\WB.spu_AddAction.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_DeleteAction.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_RestoreAction.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_DeleteActionPerm.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_UpdateAction.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_GetActionInDate.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_GetActionInMonth.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_GetActionBetweenDate.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_GetActionPage.sql'
executeSql '.\StoredProcedures\SPU.Action\WB.spu_GetTotalNumberActionPage.sql'


# Create Action SubTotals
# Create Money
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\WB.spu_GetTotalMoney.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\WB.spu_GetTotMoneyBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\WB.spu_GetTotMoneyInMonth.sql'

# Create Money by Category
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\spu_moneyByCategory\WB.spu_GetTotMoneyByCategory.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\spu_moneyByCategory\WB.spu_GetTotMoneyByCategoryBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_money\spu_moneyByCategory\WB.spu_GetTotMoneyByCategoryInMonth.sql'

# Create Expenses
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\WB.spu_GetTotalExpenses.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\WB.spu_GetTotExpensesBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\WB.spu_GetTotExpensesInMonth.sql'

# Create Expenses by Category
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\spu_expensesByCategory\WB.spu_GetTotExpensesByCategory.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\spu_expensesByCategory\WB.spu_GetTotExpensesByCategoryBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_expenses\spu_expensesByCategory\WB.spu_GetTotExpensesByCategoryInMonth.sql'

# Create Revenues
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\WB.spu_GetTotalRevenue.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\WB.spu_GetTotRevenuesBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\WB.spu_GetTotRevenuesInMonth.sql'

# Create Revenues by Category
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\spu_revenuesByCategory\WB.spu_GetTotRevenuesByCategory.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\spu_revenuesByCategory\WB.spu_GetTotRevenuesByCategoryBtwDate.sql'
executeSql '.\StoredProcedures\spu_SubTotals\spu_revenues\spu_revenuesByCategory\WB.spu_GetTotRevenuesByCategoryInMonth.sql'
