namespace VisitBosnia.WinUI.Events
{
    partial class frmFacilityGallery
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
            this.btnDelete = new System.Windows.Forms.Button();
            this.btnAdd = new System.Windows.Forms.Button();
            this.btnNext = new System.Windows.Forms.Button();
            this.btnPrevious = new System.Windows.Forms.Button();
            this.pbEvent = new System.Windows.Forms.PictureBox();
            this.labelEvent = new System.Windows.Forms.Label();
            this.ofdNewImage = new System.Windows.Forms.OpenFileDialog();
            this.labelBack = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.pbEvent)).BeginInit();
            this.SuspendLayout();
            // 
            // btnDelete
            // 
            this.btnDelete.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnDelete.Location = new System.Drawing.Point(331, 379);
            this.btnDelete.Name = "btnDelete";
            this.btnDelete.Size = new System.Drawing.Size(225, 32);
            this.btnDelete.TabIndex = 40;
            this.btnDelete.Text = "Delete selected photo";
            this.btnDelete.UseVisualStyleBackColor = true;
            this.btnDelete.Click += new System.EventHandler(this.btnDelete_Click);
            // 
            // btnAdd
            // 
            this.btnAdd.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnAdd.Location = new System.Drawing.Point(82, 379);
            this.btnAdd.Name = "btnAdd";
            this.btnAdd.Size = new System.Drawing.Size(232, 32);
            this.btnAdd.TabIndex = 39;
            this.btnAdd.Text = "Add new photo";
            this.btnAdd.UseVisualStyleBackColor = true;
            this.btnAdd.Click += new System.EventHandler(this.btnAdd_Click);
            // 
            // btnNext
            // 
            this.btnNext.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnNext.Location = new System.Drawing.Point(331, 341);
            this.btnNext.Name = "btnNext";
            this.btnNext.Size = new System.Drawing.Size(225, 32);
            this.btnNext.TabIndex = 38;
            this.btnNext.Text = "Next";
            this.btnNext.UseVisualStyleBackColor = true;
            this.btnNext.Click += new System.EventHandler(this.btnNext_Click_1);
            // 
            // btnPrevious
            // 
            this.btnPrevious.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.btnPrevious.Location = new System.Drawing.Point(82, 341);
            this.btnPrevious.Name = "btnPrevious";
            this.btnPrevious.Size = new System.Drawing.Size(232, 32);
            this.btnPrevious.TabIndex = 37;
            this.btnPrevious.Text = "Previous";
            this.btnPrevious.UseVisualStyleBackColor = true;
            this.btnPrevious.Click += new System.EventHandler(this.btnPrevious_Click);
            // 
            // pbEvent
            // 
            this.pbEvent.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle;
            this.pbEvent.Location = new System.Drawing.Point(82, 71);
            this.pbEvent.Name = "pbEvent";
            this.pbEvent.Size = new System.Drawing.Size(474, 246);
            this.pbEvent.TabIndex = 36;
            this.pbEvent.TabStop = false;
            // 
            // labelEvent
            // 
            this.labelEvent.AutoSize = true;
            this.labelEvent.Font = new System.Drawing.Font("Segoe UI", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.labelEvent.Location = new System.Drawing.Point(82, 22);
            this.labelEvent.Name = "labelEvent";
            this.labelEvent.Size = new System.Drawing.Size(0, 37);
            this.labelEvent.TabIndex = 41;
            // 
            // labelBack
            // 
            this.labelBack.AutoSize = true;
            this.labelBack.Font = new System.Drawing.Font("Segoe UI", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point);
            this.labelBack.ImageAlign = System.Drawing.ContentAlignment.BottomLeft;
            this.labelBack.Location = new System.Drawing.Point(561, 445);
            this.labelBack.Name = "labelBack";
            this.labelBack.Size = new System.Drawing.Size(67, 19);
            this.labelBack.TabIndex = 42;
            this.labelBack.Text = "go back ";
            this.labelBack.Click += new System.EventHandler(this.labelBack_Click);
            // 
            // frmFacilityGallery
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 15F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(640, 473);
            this.Controls.Add(this.labelBack);
            this.Controls.Add(this.labelEvent);
            this.Controls.Add(this.btnDelete);
            this.Controls.Add(this.btnAdd);
            this.Controls.Add(this.btnNext);
            this.Controls.Add(this.btnPrevious);
            this.Controls.Add(this.pbEvent);
            this.MaximizeBox = false;
            this.Name = "frmFacilityGallery";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "frmEventGallery";
            ((System.ComponentModel.ISupportInitialize)(this.pbEvent)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Button btnDelete;
        private Button btnAdd;
        private Button btnNext;
        private Button btnPrevious;
        private PictureBox pbEvent;
        private Label labelEvent;
        private OpenFileDialog ofdNewImage;
        private Label labelBack;
    }
}