namespace VisitBosnia.WinUI.Review
{
    partial class frmReview
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
            this.label1 = new System.Windows.Forms.Label();
            this.txtSearch = new System.Windows.Forms.TextBox();
            this.btnSearch = new System.Windows.Forms.Button();
            this.dgvReviews = new System.Windows.Forms.DataGridView();
            this.labelBack = new System.Windows.Forms.Label();
            this.User = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TouristFacility = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Rating = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Text = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dgvReviews)).BeginInit();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Segoe UI", 25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.label1.Location = new System.Drawing.Point(24, 9);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(147, 46);
            this.label1.TabIndex = 0;
            this.label1.Text = "Reviews";
            // 
            // txtSearch
            // 
            this.txtSearch.Location = new System.Drawing.Point(24, 67);
            this.txtSearch.Name = "txtSearch";
            this.txtSearch.Size = new System.Drawing.Size(273, 23);
            this.txtSearch.TabIndex = 1;
            // 
            // btnSearch
            // 
            this.btnSearch.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(26)))), ((int)(((byte)(51)))), ((int)(((byte)(80)))));
            this.btnSearch.ForeColor = System.Drawing.SystemColors.ButtonHighlight;
            this.btnSearch.Location = new System.Drawing.Point(303, 59);
            this.btnSearch.Name = "btnSearch";
            this.btnSearch.Size = new System.Drawing.Size(139, 37);
            this.btnSearch.TabIndex = 2;
            this.btnSearch.Text = "Search";
            this.btnSearch.UseVisualStyleBackColor = false;
            this.btnSearch.Click += new System.EventHandler(this.btnSearch_Click);
            // 
            // dgvReviews
            // 
            this.dgvReviews.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgvReviews.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.User,
            this.TouristFacility,
            this.Rating,
            this.Text});
            this.dgvReviews.Location = new System.Drawing.Point(24, 97);
            this.dgvReviews.Name = "dgvReviews";
            this.dgvReviews.RowTemplate.Height = 25;
            this.dgvReviews.Size = new System.Drawing.Size(851, 464);
            this.dgvReviews.TabIndex = 3;
            // 
            // labelBack
            // 
            this.labelBack.AutoSize = true;
            this.labelBack.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.labelBack.Location = new System.Drawing.Point(774, 564);
            this.labelBack.Name = "labelBack";
            this.labelBack.Size = new System.Drawing.Size(101, 19);
            this.labelBack.TabIndex = 4;
            this.labelBack.Text = "back to home";
            this.labelBack.Click += new System.EventHandler(this.labelBack_Click);
            // 
            // User
            // 
            this.User.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.User.DataPropertyName = "AppUserName";
            this.User.HeaderText = "User";
            this.User.Name = "User";
            // 
            // TouristFacility
            // 
            this.TouristFacility.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.TouristFacility.DataPropertyName = "TouristFacilityName";
            this.TouristFacility.HeaderText = "TouristFacility";
            this.TouristFacility.Name = "TouristFacility";
            // 
            // Rating
            // 
            this.Rating.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Rating.DataPropertyName = "Rating";
            this.Rating.HeaderText = "Rating";
            this.Rating.Name = "Rating";
            // 
            // Text
            // 
            this.Text.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.Text.DataPropertyName = "Text";
            this.Text.HeaderText = "Text";
            this.Text.Name = "Text";
            // 
            // frmReview
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(900, 588);
            this.Controls.Add(this.labelBack);
            this.Controls.Add(this.dgvReviews);
            this.Controls.Add(this.btnSearch);
            this.Controls.Add(this.txtSearch);
            this.Controls.Add(this.label1);
            this.Name = "frmReview";
            ((System.ComponentModel.ISupportInitialize)(this.dgvReviews)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Label label1;
        private TextBox txtSearch;
        private Button btnSearch;
        private DataGridView dgvReviews;
        private Label labelBack;
        private DataGridViewTextBoxColumn User;
        private DataGridViewTextBoxColumn TouristFacility;
        private DataGridViewTextBoxColumn Rating;
        private DataGridViewTextBoxColumn Text;
    }
}