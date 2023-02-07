using System;
using System.Windows.Forms;
using HashcatManager.Properties;

namespace HashcatManager
{
    public partial class Form2_Type : Form
    {
        public Form2_Type()
        {
            InitializeComponent();
        }

        private void buttonOpenBook_Click(object sender, EventArgs e)
        {
            groupBox1.Focus();

            OpenFileDialog load = new OpenFileDialog
            {
                Filter = @"txt (*.txt)|*.txt|Все файлы (*.*)|*.*",
                RestoreDirectory = true
            };

            if (load.ShowDialog() != DialogResult.OK) { return; }
            textBox1.Text += load.FileName + " ";
        }

        private void comboBoxTypePassword_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (comboBoxTypePassword.SelectedIndex)
            {
                case 0:
                    groupBox1.Enabled = true;
                    groupBox2.Enabled = false;
                    Settings.Default.BoolTypePassword = true;
                    //textBox2.Text = null;
                    return;
                case 1:
                    groupBox1.Enabled = false;
                    groupBox2.Enabled = true;
                    Settings.Default.BoolTypePassword = false;
                    //textBox1.Text = null;
                    return;
            }
        }

        private void Form2_Type_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (textBox1.Text == "")
            {
                Settings.Default.BoolTextBook = false;
            }
            else
            {
                Settings.Default.BoolTextBook = true;
            }

            if (textBox2.Text == "")
            {
                Settings.Default.BoolTextMask = false;
            }
            else
            {
                Settings.Default.BoolTextMask = true;
            }

            Settings.Default.Form2TextBox1 = textBox1.Text;
            Settings.Default.Form2TextBox2 = textBox2.Text;

            Settings.Default.Save();
        }

        private void Form2_Type_Load(object sender, EventArgs e)
        {
            textBox1.Text = Settings.Default.Form2TextBox1;
            textBox2.Text = Settings.Default.Form2TextBox2;

            if (textBox2.Text == "")
            {
                textBox2.Text = "?d?d?d?d?d?d?d?d";
            }

            if (Settings.Default.BoolTypePassword == true)
            {
                comboBoxTypePassword.SelectedIndex = 0;
                groupBox1.Enabled = true;
                groupBox2.Enabled = false;
            }

            if (Settings.Default.BoolTypePassword == false)
            {
                comboBoxTypePassword.SelectedIndex = 1;
                groupBox1.Enabled = false;
                groupBox2.Enabled = true;
            }
        }
    }
}
