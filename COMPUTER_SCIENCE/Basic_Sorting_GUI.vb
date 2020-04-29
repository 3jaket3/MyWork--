Public Class Form1
    Dim Names() As String = {""}

    Private Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        Me.Close()
    End Sub

    Private Sub btnReadIn_Click(sender As Object, e As EventArgs) Handles btnReadIn.Click
        Dim path As String = "C:\Users\JakeT\OneDrive\Documents\Visual Studio 2015\Projects\WindowsApplication4\names.txt"
        'Al-Jazari was typed al-Jazari and this made it the least as uppercase where valued higher so i changed it
        Names = IO.File.ReadAllLines(path)
        lstBoxInput.DataSource = Names
    End Sub

    Private Sub btnAsendOrder_Click(sender As Object, e As EventArgs) Handles btnAsendOrder.Click
        Dim temp As String
        Dim swaps As Integer = 0
        lstBoxSortedOutput.DataSource = Nothing
        For n As Integer = Names.GetUpperBound(0) To 0 Step -1
            For i As Integer = 0 To n - 1
                If Names(i) > Names(i + 1) Then
                    temp = Names(i)
                    Names(i) = Names(i + 1)
                    Names(i + 1) = temp
                    swaps = swaps + 1
                End If
            Next
            If swaps = 0 Then
                Exit For
            End If

        Next
        txtSwaps.Text = CStr(swaps)
        lstBoxSortedOutput.DataSource = Names
    End Sub

    Private Sub btnDsendOrder_Click(sender As Object, e As EventArgs) Handles btnDsendOrder.Click
        Dim temp As String
        Dim swaps As Integer = 0
        lstBoxSortedOutput.DataSource = Nothing
        For n As Integer = Names.GetUpperBound(0) To 0 Step -1
            For i As Integer = 0 To n - 1
                If Names(i) < Names(i + 1) Then
                    temp = Names(i)
                    Names(i) = Names(i + 1)
                    Names(i + 1) = temp
                    swaps = swaps + 1
                End If
            Next
            If swaps = 0 Then
                Exit For
            End If
        Next
        txtSwaps.Text = CStr(swaps)
        lstBoxSortedOutput.DataSource = Names
    End Sub
End Class
