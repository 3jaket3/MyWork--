Public Class Assingment1_Jake_Tully

    Private Sub btnRed_Click(sender As Object, e As EventArgs) Handles btnRed.Click
        'Changes Form background to red'
        Me.BackColor = Color.Red
    End Sub

    Private Sub btnBlue_Click(sender As Object, e As EventArgs) Handles btnBlue.Click
        'Changes Form background to blue'
        Me.BackColor = Color.Blue
    End Sub

    Private Sub btnDisplay_Click(sender As Object, e As EventArgs) Handles btnDisplay.Click
        'Makes Label visible and sets the text to the contents of the text box'
        lblDisplay.Text = txtDisplay.Text
        lblDisplay.Visible = True

    End Sub

    Private Sub ComboBox1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles BackgroundBox.SelectedIndexChanged
        'Sets background color to the color selected on the combo box'
        If (BackgroundBox.SelectedItem.ToString() = "Pink") Then

            Me.BackColor = Color.Pink

        End If
        If (BackgroundBox.SelectedItem.ToString() = "Yellow") Then

            Me.BackColor = Color.Yellow

        End If
        If (BackgroundBox.SelectedItem.ToString() = "Green") Then

            Me.BackColor = Color.Green

        End If
        If (BackgroundBox.SelectedItem.ToString() = "Orange") Then

            Me.BackColor = Color.Orange

        End If
    End Sub

    Private Sub btnExit_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        'Exits the application'
        Me.Close()
    End Sub

    Private Sub Assingment1_Jake_Tully_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        'Initializes the background color to purple (red+blue)'
        Me.BackColor = Color.Purple
    End Sub
End Class
