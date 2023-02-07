namespace HashcatManager
{
    partial class Form2_Type
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
            this.labelPassword5 = new System.Windows.Forms.Label();
            this.comboBoxTypePassword = new System.Windows.Forms.ComboBox();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.buttonOpenBook = new System.Windows.Forms.Button();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // labelPassword5
            // 
            this.labelPassword5.AutoSize = true;
            this.labelPassword5.Location = new System.Drawing.Point(6, 15);
            this.labelPassword5.Name = "labelPassword5";
            this.labelPassword5.Size = new System.Drawing.Size(42, 13);
            this.labelPassword5.TabIndex = 11;
            this.labelPassword5.Text = "Метод:";
            // 
            // comboBoxTypePassword
            // 
            this.comboBoxTypePassword.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBoxTypePassword.FormattingEnabled = true;
            this.comboBoxTypePassword.Items.AddRange(new object[] {
            " Словарь",
            " Маска"});
            this.comboBoxTypePassword.Location = new System.Drawing.Point(54, 12);
            this.comboBoxTypePassword.Name = "comboBoxTypePassword";
            this.comboBoxTypePassword.Size = new System.Drawing.Size(225, 21);
            this.comboBoxTypePassword.TabIndex = 10;
            this.comboBoxTypePassword.SelectedIndexChanged += new System.EventHandler(this.comboBoxTypePassword_SelectedIndexChanged);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.buttonOpenBook);
            this.groupBox1.Controls.Add(this.textBox1);
            this.groupBox1.Location = new System.Drawing.Point(285, 8);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(270, 211);
            this.groupBox1.TabIndex = 12;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Словарь";
            // 
            // buttonOpenBook
            // 
            this.buttonOpenBook.Location = new System.Drawing.Point(6, 19);
            this.buttonOpenBook.Name = "buttonOpenBook";
            this.buttonOpenBook.Size = new System.Drawing.Size(258, 23);
            this.buttonOpenBook.TabIndex = 2;
            this.buttonOpenBook.Text = "Открыть...";
            this.buttonOpenBook.UseVisualStyleBackColor = true;
            this.buttonOpenBook.Click += new System.EventHandler(this.buttonOpenBook_Click);
            // 
            // textBox1
            // 
            this.textBox1.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.textBox1.Location = new System.Drawing.Point(6, 50);
            this.textBox1.Multiline = true;
            this.textBox1.Name = "textBox1";
            this.textBox1.Size = new System.Drawing.Size(258, 153);
            this.textBox1.TabIndex = 1;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBox2);
            this.groupBox2.Location = new System.Drawing.Point(9, 39);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(270, 180);
            this.groupBox2.TabIndex = 0;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Маска";
            // 
            // textBox2
            // 
            this.textBox2.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.textBox2.Location = new System.Drawing.Point(6, 19);
            this.textBox2.Multiline = true;
            this.textBox2.Name = "textBox2";
            this.textBox2.Size = new System.Drawing.Size(258, 153);
            this.textBox2.TabIndex = 3;
            // 
            // Form2_Type
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.ControlLightLight;
            this.ClientSize = new System.Drawing.Size(564, 228);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Controls.Add(this.labelPassword5);
            this.Controls.Add(this.comboBoxTypePassword);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "Form2_Type";
            this.ShowIcon = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Настройки метода";
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.Form2_Type_FormClosing);
            this.Load += new System.EventHandler(this.Form2_Type_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelPassword5;
        private System.Windows.Forms.ComboBox comboBoxTypePassword;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button buttonOpenBook;
        private System.Windows.Forms.TextBox textBox2;
    }
}