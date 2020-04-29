Public Class Assingment2JakeTully

    Function Output(ByVal x As Double, ByVal y As Double, ByVal type As String)

        Select Case type

            Case "Add"
                lstBoxOutput.Items.Add(x & " + " & y & " = " & x + y)
                Return x + y

            Case "Subtract"
                lstBoxOutput.Items.Add(x & " - " & y & " = " & x - y)

            Case "Multiply"
                lstBoxOutput.Items.Add(x & " * " & y & " = " & x * y)
                Return x * y

            Case "Divide"
                lstBoxOutput.Items.Add(x & " / " & y & " = " & x / y)
                Return x / y

        End Select
    End Function



    Private Sub btnAdd_Click(sender As Object, e As EventArgs) Handles btnAdd.Click
        txtBoxOutput.Text = CStr(Output(CDbl(txtBoxInput1.Text), CDbl(txtBoxInput2.Text), "Add"))
    End Sub

    Private Sub btnSubtract_Click(sender As Object, e As EventArgs) Handles btnSubtract.Click
        txtBoxOutput.Text = CStr(Output(CDbl(txtBoxInput1.Text), CDbl(txtBoxInput2.Text), "Subtract"))
    End Sub

    Private Sub btnMultiply_Click(sender As Object, e As EventArgs) Handles btnMultiply.Click
        txtBoxOutput.Text = CStr(Output(CDbl(txtBoxInput1.Text), CDbl(txtBoxInput2.Text), "Multiply"))
    End Sub

    Private Sub btnDivide_Click(sender As Object, e As EventArgs) Handles btnDivide.Click
        txtBoxOutput.Text = CStr(Output(CDbl(txtBoxInput1.Text), CDbl(txtBoxInput2.Text), "Divide"))
    End Sub

    Private Sub btnClearInput_Click(sender As Object, e As EventArgs) Handles btnClearInput.Click
        txtBoxInput1.Clear()
        txtBoxInput2.Clear()
    End Sub

    Private Sub btnClearOutput_Click(sender As Object, e As EventArgs) Handles btnClearOutput.Click
        txtBoxOutput.Clear()
    End Sub

    Private Sub btnClearListBox_Click(sender As Object, e As EventArgs) Handles btnClearListBox.Click
        lstBoxOutput.Items.Clear()
    End Sub
End Class
