namespace HashcatManager
{
    partial class Form1_Main
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.GroupBoxConvert = new System.Windows.Forms.GroupBox();
            this.ButtonOpenFile = new System.Windows.Forms.Button();
            this.ButtonConvert = new System.Windows.Forms.Button();
            this.LabelConvert1 = new System.Windows.Forms.Label();
            this.TextBox1 = new System.Windows.Forms.TextBox();
            this.LabelConvert3 = new System.Windows.Forms.Label();
            this.LabelConvert2 = new System.Windows.Forms.Label();
            this.GroupBoxPassword = new System.Windows.Forms.GroupBox();
            this.ButtonTypeSettings = new System.Windows.Forms.Button();
            this.LabelPassword4 = new System.Windows.Forms.Label();
            this.ButtonPasswordOpen = new System.Windows.Forms.Button();
            this.TextBox3 = new System.Windows.Forms.TextBox();
            this.ComboBoxBruteForceSpeed = new System.Windows.Forms.ComboBox();
            this.LabelPassword3 = new System.Windows.Forms.Label();
            this.LabelPassword2 = new System.Windows.Forms.Label();
            this.TextBox2 = new System.Windows.Forms.TextBox();
            this.LabelPassword1 = new System.Windows.Forms.Label();
            this.ButtonStartPassword = new System.Windows.Forms.Button();
            this.ComboBoxBitProgramm = new System.Windows.Forms.ComboBox();
            this.GroupBoxConvert.SuspendLayout();
            this.GroupBoxPassword.SuspendLayout();
            this.SuspendLayout();
            // 
            // GroupBoxConvert
            // 
            this.GroupBoxConvert.Controls.Add(this.ButtonOpenFile);
            this.GroupBoxConvert.Controls.Add(this.ButtonConvert);
            this.GroupBoxConvert.Controls.Add(this.LabelConvert1);
            this.GroupBoxConvert.Controls.Add(this.TextBox1);
            this.GroupBoxConvert.Location = new System.Drawing.Point(12, 25);
            this.GroupBoxConvert.Name = "GroupBoxConvert";
            this.GroupBoxConvert.Size = new System.Drawing.Size(279, 89);
            this.GroupBoxConvert.TabIndex = 0;
            this.GroupBoxConvert.TabStop = false;
            this.GroupBoxConvert.Text = "Конвертирование HandShake";
            // 
            // ButtonOpenFile
            // 
            this.ButtonOpenFile.Location = new System.Drawing.Point(6, 58);
            this.ButtonOpenFile.Name = "ButtonOpenFile";
            this.ButtonOpenFile.Size = new System.Drawing.Size(128, 23);
            this.ButtonOpenFile.TabIndex = 5;
            this.ButtonOpenFile.Text = "Открыть...";
            this.ButtonOpenFile.UseVisualStyleBackColor = true;
            this.ButtonOpenFile.Click += new System.EventHandler(this.ButtonConvertOpen_Click);
            // 
            // ButtonConvert
            // 
            this.ButtonConvert.BackColor = System.Drawing.SystemColors.ControlLight;
            this.ButtonConvert.Location = new System.Drawing.Point(140, 58);
            this.ButtonConvert.Name = "ButtonConvert";
            this.ButtonConvert.Size = new System.Drawing.Size(128, 23);
            this.ButtonConvert.TabIndex = 4;
            this.ButtonConvert.Text = "Конвертировать";
            this.ButtonConvert.UseVisualStyleBackColor = false;
            this.ButtonConvert.Click += new System.EventHandler(this.ButtonConvert_Click);
            // 
            // LabelConvert1
            // 
            this.LabelConvert1.AutoSize = true;
            this.LabelConvert1.Location = new System.Drawing.Point(6, 16);
            this.LabelConvert1.Name = "LabelConvert1";
            this.LabelConvert1.Size = new System.Drawing.Size(107, 13);
            this.LabelConvert1.TabIndex = 0;
            this.LabelConvert1.Text = "Путь к файлу (.cap):";
            // 
            // TextBox1
            // 
            this.TextBox1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.TextBox1.Location = new System.Drawing.Point(6, 32);
            this.TextBox1.Name = "TextBox1";
            this.TextBox1.ReadOnly = true;
            this.TextBox1.Size = new System.Drawing.Size(262, 20);
            this.TextBox1.TabIndex = 2;
            // 
            // LabelConvert3
            // 
            this.LabelConvert3.AutoSize = true;
            this.LabelConvert3.ForeColor = System.Drawing.Color.Orange;
            this.LabelConvert3.Location = new System.Drawing.Point(69, 9);
            this.LabelConvert3.Name = "LabelConvert3";
            this.LabelConvert3.Size = new System.Drawing.Size(68, 13);
            this.LabelConvert3.TabIndex = 0;
            this.LabelConvert3.Text = "Ожидание...";
            // 
            // LabelConvert2
            // 
            this.LabelConvert2.AutoSize = true;
            this.LabelConvert2.Location = new System.Drawing.Point(9, 9);
            this.LabelConvert2.Name = "LabelConvert2";
            this.LabelConvert2.Size = new System.Drawing.Size(64, 13);
            this.LabelConvert2.TabIndex = 0;
            this.LabelConvert2.Text = "Состояние:";
            // 
            // GroupBoxPassword
            // 
            this.GroupBoxPassword.Controls.Add(this.ButtonTypeSettings);
            this.GroupBoxPassword.Controls.Add(this.LabelPassword4);
            this.GroupBoxPassword.Controls.Add(this.ButtonPasswordOpen);
            this.GroupBoxPassword.Controls.Add(this.TextBox3);
            this.GroupBoxPassword.Controls.Add(this.ComboBoxBruteForceSpeed);
            this.GroupBoxPassword.Controls.Add(this.LabelPassword3);
            this.GroupBoxPassword.Controls.Add(this.LabelPassword2);
            this.GroupBoxPassword.Controls.Add(this.TextBox2);
            this.GroupBoxPassword.Controls.Add(this.LabelPassword1);
            this.GroupBoxPassword.Controls.Add(this.ButtonStartPassword);
            this.GroupBoxPassword.Controls.Add(this.ComboBoxBitProgramm);
            this.GroupBoxPassword.Location = new System.Drawing.Point(12, 120);
            this.GroupBoxPassword.Name = "GroupBoxPassword";
            this.GroupBoxPassword.Size = new System.Drawing.Size(279, 186);
            this.GroupBoxPassword.TabIndex = 0;
            this.GroupBoxPassword.TabStop = false;
            this.GroupBoxPassword.Text = "Подбор пароля:";
            // 
            // ButtonTypeSettings
            // 
            this.ButtonTypeSettings.Location = new System.Drawing.Point(5, 67);
            this.ButtonTypeSettings.Name = "ButtonTypeSettings";
            this.ButtonTypeSettings.Size = new System.Drawing.Size(268, 23);
            this.ButtonTypeSettings.TabIndex = 99;
            this.ButtonTypeSettings.Text = "Настройки метода";
            this.ButtonTypeSettings.UseVisualStyleBackColor = true;
            this.ButtonTypeSettings.Click += new System.EventHandler(this.ButtonTypeSettings_Click);
            // 
            // LabelPassword4
            // 
            this.LabelPassword4.AutoSize = true;
            this.LabelPassword4.Location = new System.Drawing.Point(8, 115);
            this.LabelPassword4.Name = "LabelPassword4";
            this.LabelPassword4.Size = new System.Drawing.Size(124, 13);
            this.LabelPassword4.TabIndex = 8;
            this.LabelPassword4.Text = "Путь к файлу (.hccapx):";
            // 
            // ButtonPasswordOpen
            // 
            this.ButtonPasswordOpen.Location = new System.Drawing.Point(5, 157);
            this.ButtonPasswordOpen.Name = "ButtonPasswordOpen";
            this.ButtonPasswordOpen.Size = new System.Drawing.Size(128, 23);
            this.ButtonPasswordOpen.TabIndex = 6;
            this.ButtonPasswordOpen.Text = "Открыть...";
            this.ButtonPasswordOpen.UseVisualStyleBackColor = true;
            this.ButtonPasswordOpen.Click += new System.EventHandler(this.ButtonPasswordOpen_Click);
            // 
            // TextBox3
            // 
            this.TextBox3.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.TextBox3.Location = new System.Drawing.Point(5, 131);
            this.TextBox3.Name = "TextBox3";
            this.TextBox3.ReadOnly = true;
            this.TextBox3.Size = new System.Drawing.Size(263, 20);
            this.TextBox3.TabIndex = 98;
            // 
            // ComboBoxBruteForceSpeed
            // 
            this.ComboBoxBruteForceSpeed.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBoxBruteForceSpeed.FormattingEnabled = true;
            this.ComboBoxBruteForceSpeed.Items.AddRange(new object[] {
            " Слабая",
            " Средняя",
            " Сильная",
            " Максимальная"});
            this.ComboBoxBruteForceSpeed.Location = new System.Drawing.Point(88, 40);
            this.ComboBoxBruteForceSpeed.Name = "ComboBoxBruteForceSpeed";
            this.ComboBoxBruteForceSpeed.Size = new System.Drawing.Size(185, 21);
            this.ComboBoxBruteForceSpeed.TabIndex = 7;
            this.ComboBoxBruteForceSpeed.SelectedIndexChanged += new System.EventHandler(this.ComboBoxBruteForceSpeed_SelectedIndexChanged);
            // 
            // LabelPassword3
            // 
            this.LabelPassword3.AutoSize = true;
            this.LabelPassword3.Location = new System.Drawing.Point(24, 43);
            this.LabelPassword3.Name = "LabelPassword3";
            this.LabelPassword3.Size = new System.Drawing.Size(58, 13);
            this.LabelPassword3.TabIndex = 6;
            this.LabelPassword3.Text = "Скорость:";
            // 
            // LabelPassword2
            // 
            this.LabelPassword2.AutoSize = true;
            this.LabelPassword2.Location = new System.Drawing.Point(6, 16);
            this.LabelPassword2.Name = "LabelPassword2";
            this.LabelPassword2.Size = new System.Drawing.Size(76, 13);
            this.LabelPassword2.TabIndex = 5;
            this.LabelPassword2.Text = "Разрядность:";
            // 
            // TextBox2
            // 
            this.TextBox2.Location = new System.Drawing.Point(199, 91);
            this.TextBox2.Name = "TextBox2";
            this.TextBox2.Size = new System.Drawing.Size(20, 20);
            this.TextBox2.TabIndex = 4;
            this.TextBox2.Text = "90";
            this.TextBox2.KeyPress += new System.Windows.Forms.KeyPressEventHandler(this.TextBoxPassword1_KeyPress);
            // 
            // LabelPassword1
            // 
            this.LabelPassword1.AutoSize = true;
            this.LabelPassword1.Location = new System.Drawing.Point(8, 94);
            this.LabelPassword1.Name = "LabelPassword1";
            this.LabelPassword1.Size = new System.Drawing.Size(256, 13);
            this.LabelPassword1.TabIndex = 3;
            this.LabelPassword1.Text = "Отключить процесс при достижении         C° GPU";
            // 
            // ButtonStartPassword
            // 
            this.ButtonStartPassword.Location = new System.Drawing.Point(140, 157);
            this.ButtonStartPassword.Name = "ButtonStartPassword";
            this.ButtonStartPassword.Size = new System.Drawing.Size(128, 23);
            this.ButtonStartPassword.TabIndex = 2;
            this.ButtonStartPassword.Text = "Запустить";
            this.ButtonStartPassword.UseVisualStyleBackColor = true;
            this.ButtonStartPassword.Click += new System.EventHandler(this.ButtonStartPassword_Click);
            // 
            // ComboBoxBitProgramm
            // 
            this.ComboBoxBitProgramm.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.ComboBoxBitProgramm.FormattingEnabled = true;
            this.ComboBoxBitProgramm.Items.AddRange(new object[] {
            " x86",
            " x64"});
            this.ComboBoxBitProgramm.Location = new System.Drawing.Point(88, 13);
            this.ComboBoxBitProgramm.Name = "ComboBoxBitProgramm";
            this.ComboBoxBitProgramm.Size = new System.Drawing.Size(185, 21);
            this.ComboBoxBitProgramm.TabIndex = 1;
            this.ComboBoxBitProgramm.SelectedIndexChanged += new System.EventHandler(this.ComboBoxBitProgramm_SelectedIndexChanged);
            // 
            // Form1_Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClientSize = new System.Drawing.Size(304, 315);
            this.Controls.Add(this.GroupBoxPassword);
            this.Controls.Add(this.LabelConvert3);
            this.Controls.Add(this.GroupBoxConvert);
            this.Controls.Add(this.LabelConvert2);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.Name = "Form1_Main";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "HashcatManager";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form1_Main_FormClosing);
            this.GroupBoxConvert.ResumeLayout(false);
            this.GroupBoxConvert.PerformLayout();
            this.GroupBoxPassword.ResumeLayout(false);
            this.GroupBoxPassword.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.GroupBox GroupBoxConvert;
        private System.Windows.Forms.Label LabelConvert1;
        private System.Windows.Forms.TextBox TextBox1;
        private System.Windows.Forms.GroupBox GroupBoxPassword;
        private System.Windows.Forms.Button ButtonConvert;
        private System.Windows.Forms.Label LabelConvert3;
        private System.Windows.Forms.Label LabelConvert2;
        private System.Windows.Forms.Button ButtonOpenFile;
        private System.Windows.Forms.ComboBox ComboBoxBitProgramm;
        private System.Windows.Forms.Button ButtonStartPassword;
        private System.Windows.Forms.TextBox TextBox2;
        private System.Windows.Forms.Label LabelPassword1;
        private System.Windows.Forms.ComboBox ComboBoxBruteForceSpeed;
        private System.Windows.Forms.Label LabelPassword3;
        private System.Windows.Forms.Label LabelPassword2;
        private System.Windows.Forms.Label LabelPassword4;
        private System.Windows.Forms.Button ButtonPasswordOpen;
        private System.Windows.Forms.TextBox TextBox3;
        private System.Windows.Forms.Button ButtonTypeSettings;
    }
}