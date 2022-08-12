namespace VisitBosnia.WinUI
{
    partial class frmRegister
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
            this.components = new System.ComponentModel.Container();
            this.panel1 = new System.Windows.Forms.Panel();
            this.label2 = new System.Windows.Forms.Label();
            this.cbAgency = new System.Windows.Forms.ComboBox();
            this.txtConfirmPass = new System.Windows.Forms.TextBox();
            this.txtPassword = new System.Windows.Forms.TextBox();
            this.txtPhone = new System.Windows.Forms.TextBox();
            this.txtEmail = new System.Windows.Forms.TextBox();
            this.txtUsername = new System.Windows.Forms.TextBox();
            this.txtLastName = new System.Windows.Forms.TextBox();
            this.dtpDateOfBirth = new System.Windows.Forms.DateTimePicker();
            this.btnRegister = new System.Windows.Forms.Button();
            this.txtFirstName = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.btnChooseImage = new System.Windows.Forms.Button();
            this.error = new System.Windows.Forms.ErrorProvider(this.components);
            this.fileDialog = new System.Windows.Forms.OpenFileDialog();
            this.pbProfilePicture = new VisitBosnia.WinUI.CustomInput.Picture();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.error)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbProfilePicture)).BeginInit();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(26)))), ((int)(((byte)(51)))), ((int)(((byte)(80)))));
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.cbAgency);
            this.panel1.Controls.Add(this.txtConfirmPass);
            this.panel1.Controls.Add(this.txtPassword);
            this.panel1.Controls.Add(this.txtPhone);
            this.panel1.Controls.Add(this.txtEmail);
            this.panel1.Controls.Add(this.txtUsername);
            this.panel1.Controls.Add(this.txtLastName);
            this.panel1.Controls.Add(this.dtpDateOfBirth);
            this.panel1.Controls.Add(this.btnRegister);
            this.panel1.Controls.Add(this.txtFirstName);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Location = new System.Drawing.Point(349, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(589, 519);
            this.panel1.TabIndex = 0;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label2.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.label2.Location = new System.Drawing.Point(39, 327);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(57, 19);
            this.label2.TabIndex = 10;
            this.label2.Text = "Agency:";
            this.label2.Click += new System.EventHandler(this.label2_Click);
            // 
            // cbAgency
            // 
            this.cbAgency.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.cbAgency.FormattingEnabled = true;
            this.cbAgency.Location = new System.Drawing.Point(39, 350);
            this.cbAgency.Name = "cbAgency";
            this.cbAgency.Size = new System.Drawing.Size(508, 25);
            this.cbAgency.TabIndex = 9;
            this.cbAgency.SelectedIndexChanged += new System.EventHandler(this.cbAgency_SelectedIndexChanged);
            // 
            // txtConfirmPass
            // 
            this.txtConfirmPass.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtConfirmPass.Location = new System.Drawing.Point(312, 234);
            this.txtConfirmPass.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtConfirmPass.Name = "txtConfirmPass";
            this.txtConfirmPass.PasswordChar = '*';
            this.txtConfirmPass.PlaceholderText = "Confirm password";
            this.txtConfirmPass.Size = new System.Drawing.Size(235, 27);
            this.txtConfirmPass.TabIndex = 6;
            this.txtConfirmPass.TextChanged += new System.EventHandler(this.txtConfirmPass_TextChanged);
            this.txtConfirmPass.Validating += new System.ComponentModel.CancelEventHandler(this.txtConfirmPass_Validating);
            // 
            // txtPassword
            // 
            this.txtPassword.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtPassword.Location = new System.Drawing.Point(312, 186);
            this.txtPassword.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtPassword.Name = "txtPassword";
            this.txtPassword.PasswordChar = '*';
            this.txtPassword.PlaceholderText = "Password";
            this.txtPassword.Size = new System.Drawing.Size(235, 27);
            this.txtPassword.TabIndex = 5;
            this.txtPassword.TextChanged += new System.EventHandler(this.txtPassword_TextChanged);
            this.txtPassword.Validating += new System.ComponentModel.CancelEventHandler(this.txtPassword_Validating);
            // 
            // txtPhone
            // 
            this.txtPhone.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtPhone.Location = new System.Drawing.Point(312, 136);
            this.txtPhone.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtPhone.Name = "txtPhone";
            this.txtPhone.PlaceholderText = "Phone number";
            this.txtPhone.Size = new System.Drawing.Size(235, 27);
            this.txtPhone.TabIndex = 4;
            this.txtPhone.TextChanged += new System.EventHandler(this.txtPhone_TextChanged);
            this.txtPhone.Validating += new System.ComponentModel.CancelEventHandler(this.txtPhone_Validating);
            // 
            // txtEmail
            // 
            this.txtEmail.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtEmail.Location = new System.Drawing.Point(39, 234);
            this.txtEmail.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtEmail.Name = "txtEmail";
            this.txtEmail.PlaceholderText = "Email";
            this.txtEmail.Size = new System.Drawing.Size(235, 27);
            this.txtEmail.TabIndex = 2;
            this.txtEmail.TextChanged += new System.EventHandler(this.txtEmail_TextChanged);
            this.txtEmail.Validating += new System.ComponentModel.CancelEventHandler(this.txtEmail_Validating);
            // 
            // txtUsername
            // 
            this.txtUsername.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtUsername.Location = new System.Drawing.Point(39, 282);
            this.txtUsername.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtUsername.Name = "txtUsername";
            this.txtUsername.PlaceholderText = "Username";
            this.txtUsername.Size = new System.Drawing.Size(235, 27);
            this.txtUsername.TabIndex = 3;
            this.txtUsername.TextChanged += new System.EventHandler(this.txtUsername_TextChanged);
            this.txtUsername.Validating += new System.ComponentModel.CancelEventHandler(this.txtUsername_Validating);
            // 
            // txtLastName
            // 
            this.txtLastName.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtLastName.Location = new System.Drawing.Point(39, 186);
            this.txtLastName.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtLastName.Name = "txtLastName";
            this.txtLastName.PlaceholderText = "Last name";
            this.txtLastName.Size = new System.Drawing.Size(235, 27);
            this.txtLastName.TabIndex = 1;
            this.txtLastName.TextChanged += new System.EventHandler(this.txtLastName_TextChanged);
            this.txtLastName.Validating += new System.ComponentModel.CancelEventHandler(this.txtLastName_Validating);
            // 
            // dtpDateOfBirth
            // 
            this.dtpDateOfBirth.AccessibleDescription = "";
            this.dtpDateOfBirth.CalendarForeColor = System.Drawing.SystemColors.WindowFrame;
            this.dtpDateOfBirth.CalendarTitleForeColor = System.Drawing.SystemColors.WindowFrame;
            this.dtpDateOfBirth.CalendarTrailingForeColor = System.Drawing.SystemColors.WindowFrame;
            this.dtpDateOfBirth.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.dtpDateOfBirth.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dtpDateOfBirth.Location = new System.Drawing.Point(312, 282);
            this.dtpDateOfBirth.MinimumSize = new System.Drawing.Size(235, 27);
            this.dtpDateOfBirth.Name = "dtpDateOfBirth";
            this.dtpDateOfBirth.Size = new System.Drawing.Size(235, 27);
            this.dtpDateOfBirth.TabIndex = 7;
            this.dtpDateOfBirth.ValueChanged += new System.EventHandler(this.dtpDateOfBirth_ValueChanged);
            // 
            // btnRegister
            // 
            this.btnRegister.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.btnRegister.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnRegister.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnRegister.Location = new System.Drawing.Point(132, 415);
            this.btnRegister.Name = "btnRegister";
            this.btnRegister.Size = new System.Drawing.Size(315, 30);
            this.btnRegister.TabIndex = 8;
            this.btnRegister.Text = "Register";
            this.btnRegister.UseVisualStyleBackColor = false;
            this.btnRegister.Click += new System.EventHandler(this.btnRegister_Click);
            // 
            // txtFirstName
            // 
            this.txtFirstName.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.txtFirstName.Location = new System.Drawing.Point(39, 136);
            this.txtFirstName.MinimumSize = new System.Drawing.Size(235, 27);
            this.txtFirstName.Name = "txtFirstName";
            this.txtFirstName.PlaceholderText = "First name";
            this.txtFirstName.Size = new System.Drawing.Size(235, 27);
            this.txtFirstName.TabIndex = 0;
            this.txtFirstName.TextChanged += new System.EventHandler(this.txtFirstName_TextChanged);
            this.txtFirstName.Validating += new System.ComponentModel.CancelEventHandler(this.txtFirstName_Validating);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label1.ForeColor = System.Drawing.SystemColors.Control;
            this.label1.Location = new System.Drawing.Point(163, 35);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(269, 37);
            this.label1.TabIndex = 1;
            this.label1.Text = "Create new account";
            this.label1.Click += new System.EventHandler(this.label1_Click);
            // 
            // btnChooseImage
            // 
            this.btnChooseImage.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(26)))), ((int)(((byte)(51)))), ((int)(((byte)(80)))));
            this.btnChooseImage.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnChooseImage.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnChooseImage.ForeColor = System.Drawing.SystemColors.Control;
            this.btnChooseImage.Location = new System.Drawing.Point(74, 350);
            this.btnChooseImage.Name = "btnChooseImage";
            this.btnChooseImage.Size = new System.Drawing.Size(193, 33);
            this.btnChooseImage.TabIndex = 1;
            this.btnChooseImage.Text = "Choose image...";
            this.btnChooseImage.UseVisualStyleBackColor = false;
            this.btnChooseImage.Click += new System.EventHandler(this.btnChooseImage_Click);
            // 
            // error
            // 
            this.error.ContainerControl = this;
            // 
            // fileDialog
            // 
            this.fileDialog.FileName = "openFileDialog1";
            // 
            // pbProfilePicture
            // 
            this.pbProfilePicture.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Stretch;
            this.pbProfilePicture.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pbProfilePicture.Image = global::VisitBosnia.WinUI.Properties.Resources.user;
            this.pbProfilePicture.Location = new System.Drawing.Point(37, 72);
            this.pbProfilePicture.Name = "pbProfilePicture";
            this.pbProfilePicture.Size = new System.Drawing.Size(266, 259);
            this.pbProfilePicture.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pbProfilePicture.TabIndex = 2;
            this.pbProfilePicture.TabStop = false;
            this.pbProfilePicture.Click += new System.EventHandler(this.pbProfilePicture_Click);
            // 
            // frmRegister
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientActiveCaption;
            this.ClientSize = new System.Drawing.Size(931, 515);
            this.Controls.Add(this.pbProfilePicture);
            this.Controls.Add(this.btnChooseImage);
            this.Controls.Add(this.panel1);
            this.MaximizeBox = false;
            this.Name = "frmRegister";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Register";
            this.Load += new System.EventHandler(this.Register_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.error)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pbProfilePicture)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private Panel panel1;
        private Label label1;
        private Button btnRegister;
        private TextBox txtFirstName;
        private Button btnChooseImage;
        private DateTimePicker dtpDateOfBirth;
        private TextBox txtConfirmPass;
        private TextBox txtPassword;
        private TextBox txtPhone;
        private TextBox txtEmail;
        private TextBox txtUsername;
        private TextBox txtLastName;
        private ErrorProvider error;
        private OpenFileDialog fileDialog;
        private CustomInput.Picture pbProfilePicture;
        private Label label2;
        private ComboBox cbAgency;
    }
}