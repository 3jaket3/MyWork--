using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Assingment1
{
    public partial class Assingment1_jake_tully : Form
    {
        public Assingment1_jake_tully()
        {
            InitializeComponent();
            BackColor = Color.Purple;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Changes background to blue and foreground to red
            ActiveForm.BackColor = Color.Blue;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            // Changes background to red and foreground to blue
            ActiveForm.BackColor = Color.Red;
        }

        private void btnDisplay_Click(object sender, EventArgs e)
        {
            // Displays text from textbox on in the label
            lblDisplay.Text = txtDisplay.Text;
            lblDisplay.Visible = true;
        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            // closes the application
            Application.Exit();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
          // Sets color to the selected color from drop down menue

            if (comboBox1.SelectedItem.ToString() == "Pink")
            {
                ActiveForm.BackColor = Color.Pink;
            }
            if (comboBox1.SelectedItem.ToString() == "Yellow")
            {
                ActiveForm.BackColor = Color.Yellow;
            }
            if (comboBox1.SelectedItem.ToString() == "Orange")
            {
                ActiveForm.BackColor = Color.Orange;
            }
            if(comboBox1.SelectedItem.ToString() == "Green")
            {
                ActiveForm.BackColor = Color.Green;
            }
        }

        private void Assingment1_jake_tully_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click_1(object sender, EventArgs e)
        {

        }
    }
}
