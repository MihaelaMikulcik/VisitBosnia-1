namespace VisitBosnia.WinUI.Events
{
    partial class frmEventDetails
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtPleace = new System.Windows.Forms.TextBox();
            this.txtName = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.cbCity = new System.Windows.Forms.ComboBox();
            this.cbGuide = new System.Windows.Forms.ComboBox();
            this.label13 = new System.Windows.Forms.Label();
            this.txtDescription = new System.Windows.Forms.TextBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.btnSave = new System.Windows.Forms.Button();
            this.ofdNewImage = new System.Windows.Forms.OpenFileDialog();
            this.dtpDate = new System.Windows.Forms.DateTimePicker();
            this.numberMax = new System.Windows.Forms.NumericUpDown();
            this.numberPrice = new System.Windows.Forms.NumericUpDown();
            this.cbCategory = new System.Windows.Forms.ComboBox();
            this.label14 = new System.Windows.Forms.Label();
            this.label15 = new System.Windows.Forms.Label();
            this.nFromH = new System.Windows.Forms.NumericUpDown();
            this.nFromM = new System.Windows.Forms.NumericUpDown();
            this.label16 = new System.Windows.Forms.Label();
            this.label17 = new System.Windows.Forms.Label();
            this.nToM = new System.Windows.Forms.NumericUpDown();
            this.nToH = new System.Windows.Forms.NumericUpDown();
            this.errorProvider = new System.Windows.Forms.ErrorProvider(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.numberMax)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numberPrice)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nFromH)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nFromM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nToM)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.nToH)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 17F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(29, 20);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(153, 31);
            this.label1.TabIndex = 1;
            this.label1.Text = "Event Details";
            // 
            // txtPleace
            // 
            this.txtPleace.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtPleace.Location = new System.Drawing.Point(148, 144);
            this.txtPleace.Name = "txtPleace";
            this.txtPleace.Size = new System.Drawing.Size(195, 27);
            this.txtPleace.TabIndex = 11;
            this.txtPleace.Validating += new System.ComponentModel.CancelEventHandler(this.txtPleace_Validating);
            // 
            // txtName
            // 
            this.txtName.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtName.Location = new System.Drawing.Point(148, 94);
            this.txtName.Name = "txtName";
            this.txtName.Size = new System.Drawing.Size(195, 27);
            this.txtName.TabIndex = 10;
            this.txtName.Validating += new System.ComponentModel.CancelEventHandler(this.txtName_Validating);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label4.Location = new System.Drawing.Point(29, 194);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(44, 20);
            this.label4.TabIndex = 9;
            this.label4.Text = "Date:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label3.Location = new System.Drawing.Point(29, 129);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(52, 20);
            this.label3.TabIndex = 8;
            this.label3.Text = "Pleace";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label2.Location = new System.Drawing.Point(28, 97);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(52, 20);
            this.label2.TabIndex = 7;
            this.label2.Text = "Name:";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label5.Location = new System.Drawing.Point(407, 174);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(67, 20);
            this.label5.TabIndex = 15;
            this.label5.Text = "Price per";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label6.Location = new System.Drawing.Point(28, 240);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(37, 20);
            this.label6.TabIndex = 14;
            this.label6.Text = "City:";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label7.Location = new System.Drawing.Point(407, 97);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(51, 20);
            this.label7.TabIndex = 13;
            this.label7.Text = "Guide:";
            this.label7.Click += new System.EventHandler(this.label7_Click);
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label8.Location = new System.Drawing.Point(29, 270);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(96, 20);
            this.label8.TabIndex = 21;
            this.label8.Text = "Max number ";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label9.Location = new System.Drawing.Point(407, 289);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(28, 20);
            this.label9.TabIndex = 20;
            this.label9.Text = "To:";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label10.Location = new System.Drawing.Point(407, 240);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(46, 20);
            this.label10.TabIndex = 19;
            this.label10.Text = "From:";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label11.Location = new System.Drawing.Point(28, 289);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(108, 20);
            this.label11.TabIndex = 25;
            this.label11.Text = "of participants:";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label12.Location = new System.Drawing.Point(407, 194);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(93, 20);
            this.label12.TabIndex = 26;
            this.label12.Text = "person (KM):";
            // 
            // cbCity
            // 
            this.cbCity.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.cbCity.FormattingEnabled = true;
            this.cbCity.Location = new System.Drawing.Point(148, 236);
            this.cbCity.Name = "cbCity";
            this.cbCity.Size = new System.Drawing.Size(195, 28);
            this.cbCity.TabIndex = 27;
            // 
            // cbGuide
            // 
            this.cbGuide.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.cbGuide.FormattingEnabled = true;
            this.cbGuide.Location = new System.Drawing.Point(507, 93);
            this.cbGuide.Name = "cbGuide";
            this.cbGuide.Size = new System.Drawing.Size(195, 28);
            this.cbGuide.TabIndex = 28;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label13.Location = new System.Drawing.Point(28, 337);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(88, 20);
            this.label13.TabIndex = 29;
            this.label13.Text = "Description:";
            // 
            // txtDescription
            // 
            this.txtDescription.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.txtDescription.Location = new System.Drawing.Point(29, 360);
            this.txtDescription.Multiline = true;
            this.txtDescription.Name = "txtDescription";
            this.txtDescription.Size = new System.Drawing.Size(673, 157);
            this.txtDescription.TabIndex = 30;
            this.txtDescription.Validating += new System.ComponentModel.CancelEventHandler(this.txtDescription_Validating);
            // 
            // btnCancel
            // 
            this.btnCancel.BackColor = System.Drawing.Color.Maroon;
            this.btnCancel.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnCancel.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnCancel.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnCancel.Location = new System.Drawing.Point(134, 557);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(100, 34);
            this.btnCancel.TabIndex = 37;
            this.btnCancel.Text = "Cancel";
            this.btnCancel.UseVisualStyleBackColor = false;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.DarkGreen;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSave.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnSave.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnSave.Location = new System.Drawing.Point(28, 557);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(100, 34);
            this.btnSave.TabIndex = 36;
            this.btnSave.Text = "Save";
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // dtpDate
            // 
            this.dtpDate.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.dtpDate.Location = new System.Drawing.Point(148, 191);
            this.dtpDate.Name = "dtpDate";
            this.dtpDate.Size = new System.Drawing.Size(195, 27);
            this.dtpDate.TabIndex = 38;
            this.dtpDate.Value = new System.DateTime(2022, 7, 27, 20, 38, 0, 0);
            // 
            // numberMax
            // 
            this.numberMax.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.numberMax.Location = new System.Drawing.Point(148, 286);
            this.numberMax.Name = "numberMax";
            this.numberMax.Size = new System.Drawing.Size(195, 27);
            this.numberMax.TabIndex = 39;
            this.numberMax.Validating += new System.ComponentModel.CancelEventHandler(this.numberMax_Validating);
            // 
            // numberPrice
            // 
            this.numberPrice.DecimalPlaces = 1;
            this.numberPrice.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.numberPrice.Location = new System.Drawing.Point(507, 191);
            this.numberPrice.Name = "numberPrice";
            this.numberPrice.Size = new System.Drawing.Size(195, 27);
            this.numberPrice.TabIndex = 40;
            this.numberPrice.Validating += new System.ComponentModel.CancelEventHandler(this.numberPrice_Validating);
            // 
            // cbCategory
            // 
            this.cbCategory.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.cbCategory.FormattingEnabled = true;
            this.cbCategory.Location = new System.Drawing.Point(507, 143);
            this.cbCategory.Name = "cbCategory";
            this.cbCategory.Size = new System.Drawing.Size(195, 28);
            this.cbCategory.TabIndex = 42;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label14.Location = new System.Drawing.Point(407, 147);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(72, 20);
            this.label14.TabIndex = 41;
            this.label14.Text = "Category:";
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.label15.Location = new System.Drawing.Point(28, 147);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(95, 20);
            this.label15.TabIndex = 43;
            this.label15.Text = "of departure:";
            // 
            // nFromH
            // 
            this.nFromH.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.nFromH.Location = new System.Drawing.Point(509, 237);
            this.nFromH.Name = "nFromH";
            this.nFromH.Size = new System.Drawing.Size(71, 27);
            this.nFromH.TabIndex = 44;
            this.nFromH.Validating += new System.ComponentModel.CancelEventHandler(this.nFromH_Validating);
            // 
            // nFromM
            // 
            this.nFromM.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.nFromM.Location = new System.Drawing.Point(632, 237);
            this.nFromM.Name = "nFromM";
            this.nFromM.Size = new System.Drawing.Size(70, 27);
            this.nFromM.TabIndex = 45;
            this.nFromM.Validating += new System.ComponentModel.CancelEventHandler(this.nFromM_Validating);
            // 
            // label16
            // 
            this.label16.AutoSize = true;
            this.label16.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label16.Location = new System.Drawing.Point(596, 240);
            this.label16.Name = "label16";
            this.label16.Size = new System.Drawing.Size(14, 21);
            this.label16.TabIndex = 46;
            this.label16.Text = ":";
            // 
            // label17
            // 
            this.label17.AutoSize = true;
            this.label17.Font = new System.Drawing.Font("Segoe UI", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label17.Location = new System.Drawing.Point(596, 289);
            this.label17.Name = "label17";
            this.label17.Size = new System.Drawing.Size(14, 21);
            this.label17.TabIndex = 49;
            this.label17.Text = ":";
            // 
            // nToM
            // 
            this.nToM.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.nToM.Location = new System.Drawing.Point(632, 286);
            this.nToM.Name = "nToM";
            this.nToM.Size = new System.Drawing.Size(70, 27);
            this.nToM.TabIndex = 48;
            this.nToM.Validating += new System.ComponentModel.CancelEventHandler(this.nToM_Validating);
            // 
            // nToH
            // 
            this.nToH.Font = new System.Drawing.Font("Segoe UI", 11F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point);
            this.nToH.Location = new System.Drawing.Point(509, 286);
            this.nToH.Name = "nToH";
            this.nToH.Size = new System.Drawing.Size(71, 27);
            this.nToH.TabIndex = 47;
            this.nToH.Validating += new System.ComponentModel.CancelEventHandler(this.nToH_Validating);
            // 
            // errorProvider
            // 
            this.errorProvider.ContainerControl = this;
            // 
            // frmEventDetails
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(756, 621);
            this.Controls.Add(this.label17);
            this.Controls.Add(this.nToM);
            this.Controls.Add(this.nToH);
            this.Controls.Add(this.label16);
            this.Controls.Add(this.nFromM);
            this.Controls.Add(this.nFromH);
            this.Controls.Add(this.label15);
            this.Controls.Add(this.cbCategory);
            this.Controls.Add(this.label14);
            this.Controls.Add(this.numberPrice);
            this.Controls.Add(this.numberMax);
            this.Controls.Add(this.dtpDate);
            this.Controls.Add(this.btnCancel);
            this.Controls.Add(this.btnSave);
            this.Controls.Add(this.txtDescription);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.cbGuide);
            this.Controls.Add(this.cbCity);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.txtPleace);
            this.Controls.Add(this.txtName);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.MaximizeBox = false;
            this.Name = "frmEventDetails";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmEventDetails";
            ((System.ComponentModel.ISupportInitialize)(this.numberMax)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numberPrice)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nFromH)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nFromM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nToM)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.nToH)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.errorProvider)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Label label1;
        private TextBox txtPleace;
        private TextBox txtName;
        private Label label4;
        private Label label3;
        private Label label2;
        private Label label5;
        private Label label6;
        private Label label7;
        private Label label8;
        private Label label9;
        private Label label10;
        private Label label11;
        private Label label12;
        private ComboBox cbCity;
        private ComboBox cbGuide;
        private Label label13;
        private TextBox txtDescription;
        private Button btnCancel;
        private Button btnSave;
        private OpenFileDialog ofdNewImage;
        private DateTimePicker dtpDate;
        private NumericUpDown numberMax;
        private NumericUpDown numberPrice;
        private ComboBox cbCategory;
        private Label label14;
        private Label label15;
        private NumericUpDown nFromH;
        private NumericUpDown nFromM;
        private Label label16;
        private Label label17;
        private NumericUpDown nToM;
        private NumericUpDown nToH;
        private ErrorProvider errorProvider;
    }
}