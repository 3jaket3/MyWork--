Public Class Form1
    'global variables'
    Dim Sum As Double = 0
    Dim numItems As Integer = 0
    Dim Taxes As Double = 0

    Private Sub btnAddItem_Click(sender As Object, e As EventArgs) Handles btnAddItem.Click
        'adds an item to the list box 
        Dim Item As String
        Item = txtItem.Text & "     " & "$" & txtPrice.Text
        lstSalesReciept.Items.Add(Item)
        Sum = Sum + CDbl(txtPrice.Text) 'updates the sum of the purchases
        numItems = numItems + 1 'updates the number of items

    End Sub

    Private Sub Form1_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'formats the title of the reciept
        lstSalesReciept.Items.Add("welcome to")
        lstSalesReciept.Items.Add("mickeys Mini-Mart")
        lstSalesReciept.Items.Add("  ")
        lstSalesReciept.Items.Add(DateString & "  " & CStr(TimeOfDay))
    End Sub

    Private Sub btnCloseTransaction_Click(sender As Object, e As EventArgs) Handles btnCloseTransaction.Click
        'calculates the taxes and total of the purchases
        'formats the output
        lstSalesReciept.Items.Add("--- --- --- ---")
        Taxes = Sum * 0.13
        lstSalesReciept.Items.Add("Cost Of Items:   " & "$" & CStr(Sum))
        lstSalesReciept.Items.Add("Taxes            " & "$" & CStr(Taxes))
        lstSalesReciept.Items.Add("Total Cost:      " & "$" & CStr(Sum + Taxes))

        lstSalesReciept.Items.Add("  ")
        lstSalesReciept.Items.Add("Thank you for buying")
        lstSalesReciept.Items.Add("these " & CStr(numItems) & " Items")
        lstSalesReciept.Items.Add("From Micky's Mini-Mart.")
        lstSalesReciept.Items.Add("Please Come Again!")


    End Sub
End Class
