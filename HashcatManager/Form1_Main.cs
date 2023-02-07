using System;
using System.IO;
using System.Drawing;
using System.Threading;
using System.Diagnostics;
using System.Windows.Forms;
using HashcatManager.Properties;

namespace HashcatManager
{
    public partial class Form1_Main : Form
    {
        string Hashcat;
        string BruteForceSpeed;
        string SetTypeBruteForce;
        string TypeBruteForce;

        public Form1_Main()
        {
            InitializeComponent();
            TextBox2.MaxLength = 2;
            ComboBoxBitProgramm.SelectedIndex = Settings.Default.HashcatSelect;
            ComboBoxBruteForceSpeed.SelectedIndex = Settings.Default.SpeedSelect;
            TextBox2.Text = Settings.Default.TempGPU;

            if (File.Exists(Settings.Default.Path_hccapx))
                TextBox3.Text = Settings.Default.Path_hccapx;
        }

        /* КОНВЕРТИРОВАНИЕ: */

        private void ConsoleHandshake()
        {
            ProcessStartInfo startInfo = new ProcessStartInfo
            {
                FileName = "cmd.exe",
                Arguments = "/C " + Settings.Default.CommandHandshake,
                WindowStyle = ProcessWindowStyle.Hidden
            };
            Process.Start(startInfo);
        }

        private void ButtonConvert_Click(object sender, EventArgs e)
        {
            GroupBoxConvert.Focus();

            if (TextBox1.Text == "")
            {
                LabelConvert3.Text = "Не указан файл cap!";
                LabelConvert3.ForeColor = Color.Red;
                return;
            }

            if (!File.Exists("cap2hccapx.exe"))
            {
                LabelConvert3.Text = "cap2hccapx.exe не найден!";
                LabelConvert3.ForeColor = Color.Red;
                return;
            }

            if (File.Exists("cap2hccapx.bin"))
            {
                Settings.Default.CommandHandshake = "cap2hccapx.exe " + TextBox1.Text + " output.hccapx";
            }
            else
            {
                LabelConvert3.Text = "cap2hccapx.bin не найден!";
                LabelConvert3.ForeColor = Color.Red;
                return;
            }

            if (File.Exists("output.hccapx"))
            {
                File.Delete("output.hccapx");
            }

            Thread threadConv = new Thread(ConsoleHandshake);
            threadConv.Start();

            Thread.Sleep(3000);

            if (File.Exists("output.hccapx"))
            {
                LabelConvert3.Text = "Файл создан: output.hccapx";
                LabelConvert3.ForeColor = Color.Green;
            }
            else
            {
                LabelConvert3.Text = "Неверный путь или файл!";
                LabelConvert3.ForeColor = Color.Red;
            }
        }

        private void ButtonConvertOpen_Click(object sender, EventArgs e)
        {
            GroupBoxConvert.Focus();

            LabelConvert3.Text = "Ожидание...";
            LabelConvert3.ForeColor = Color.Orange;

            OpenFileDialog load = new OpenFileDialog
            {
                Filter = @"cap (*.cap)|*.cap|Все файлы (*.*)|*.*",
                RestoreDirectory = true
            };

            if (load.ShowDialog() != DialogResult.OK) { return; }
            TextBox1.Text = load.FileName;
        }

        /* ПОДБОР ПАРОЛЯ: */

        private void ComboBoxBitProgramm_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ComboBoxBitProgramm.SelectedIndex)
            {
                case 0:
                    Hashcat = "hashcat32.exe";
                    Settings.Default.HashcatSelect = 0;
                    return;
                case 1:
                    Hashcat = "hashcat64.exe";
                    Settings.Default.HashcatSelect = 1;
                    return;
            }
        }

        private void ComboBoxBruteForceSpeed_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ComboBoxBruteForceSpeed.SelectedIndex)
            {
                case 0:
                    BruteForceSpeed = " -w 1";
                    Settings.Default.SpeedSelect = 0;
                    return;
                case 1:
                    BruteForceSpeed = " -w 2";
                    Settings.Default.SpeedSelect = 1;
                    return;
                case 2:
                    BruteForceSpeed = " -w 3";
                    Settings.Default.SpeedSelect = 2;
                    return;
                case 3:
                    BruteForceSpeed = " -w 4";
                    Settings.Default.SpeedSelect = 3;
                    return;
            }
        }

        private void ButtonStartPassword_Click(object sender, EventArgs e)
        {
            GroupBoxConvert.Focus();

            if (TextBox3.Text == "")
            {
                LabelConvert3.Text = "Не указан файл HandShake!";
                LabelConvert3.ForeColor = Color.Red;
                return;
            }

            if (Settings.Default.BoolTypePassword == true && Settings.Default.BoolTextBook == false)
            {
                    LabelConvert3.Text = "Не указаны настройки метода (Словарь)!";
                    LabelConvert3.ForeColor = Color.Red;
                    return;
            }

            if (Settings.Default.BoolTypePassword == false && Settings.Default.BoolTextMask == false)
            {
                    LabelConvert3.Text = "Не указаны настройки метода (Маска)!";
                    LabelConvert3.ForeColor = Color.Red;
                    return;
            }

            if (Settings.Default.BoolTypePassword == true)
            {
                SetTypeBruteForce = Settings.Default.Form2TextBox1;
                TypeBruteForce = null;
            }

            if (Settings.Default.BoolTypePassword == false)
            {
                SetTypeBruteForce = Settings.Default.Form2TextBox2;
                TypeBruteForce = "-a 3 ";
            }

            if (TextBox2.Text == "")
            {
                TextBox2.Text = "80";
            }

            LabelConvert3.Text = "Старт...";
            LabelConvert3.ForeColor = Color.Green;

            Settings.Default.CommandPassword = Hashcat + " -m 2500" + " --gpu-temp-abort=" + TextBox2.Text + BruteForceSpeed + " " + TypeBruteForce + TextBox3.Text + " " + SetTypeBruteForce;
            Process.Start("cmd.exe", "/k " + Settings.Default.CommandPassword);
        }

        private void ButtonPasswordOpen_Click(object sender, EventArgs e)
        {
            GroupBoxConvert.Focus();

            LabelConvert3.Text = "Ожидание...";
            LabelConvert3.ForeColor = Color.Orange;

            OpenFileDialog load = new OpenFileDialog
            {
                Filter = @"hccapx (*.hccapx)|*.hccapx|Все файлы (*.*)|*.*",
                RestoreDirectory = true
            };

            if (load.ShowDialog() != DialogResult.OK) { return; }
            TextBox3.Text = load.FileName;
        }

        private void ButtonTypeSettings_Click(object sender, EventArgs e)
        {
            GroupBoxConvert.Focus();
            Form2_Type a = new Form2_Type();
            a.ShowDialog();
        }

        private void Form1_Main_FormClosing(object sender, FormClosingEventArgs e)
        {
            Settings.Default.CommandHandshake = Settings.Default.CommandPassword = null;
            Settings.Default.TempGPU = TextBox2.Text;
            Settings.Default.Path_hccapx = TextBox3.Text;
            Settings.Default.Save();
        }

        private void TextBoxPassword1_KeyPress(object sender, KeyPressEventArgs e)
        {
            char ch = e.KeyChar;
            if (!char.IsDigit(ch) && ch != 8)
            {
                e.Handled = true;
            }
        }
    }
}
