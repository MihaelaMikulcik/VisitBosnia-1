using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.Model.Requests;

namespace VisitBosnia.WinUI.Categories
{
    public partial class frmCategoryDetails : Form
    {
        public APIService CategoryService { get; set; } = new APIService("Category");

        private Model.Category _model;
        public frmCategoryDetails(Model.Category model = null)
        {
            InitializeComponent();
            _model = model;
            LoadData();
        }

        private void LoadData()
        {
            if (_model != null)
            {
                txtName.Text = _model.Name;
                txtDescription.Text = _model.Description;
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var frmCategory = new frmCategory();
            frmCategory.Closed += (s, args) => this.Close();
            frmCategory.Show();
        }

        private void txtName_Validating(object sender, CancelEventArgs e)
        {

            if (string.IsNullOrWhiteSpace(txtName.Text))
            {
                e.Cancel = true;
                txtName.Focus();
                errorProvider.SetError(txtName, "Name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtName, "");
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                if (_model == null)
                {
                    var insertRequest = new CategoryInsertRequest
                    {
                        Name = txtName.Text,
                        Description = txtDescription.Text
                    };
                    var newCategory = await CategoryService.Insert<Model.Category>(insertRequest);



                }
                else
                {
                    var updateRequest = new CategoryUpdateRequest
                    {
                        Description = txtDescription.Text,
                        Name = txtName.Text,
                    };
                    var updatedCategory = await CategoryService.Update<Model.Category>(_model.Id,updateRequest);
                }

                MessageBox.Show("Saved successfuly");
                this.Hide();
                var frmCategory = new frmCategory();
                frmCategory.Closed += (s, args) => this.Close();
                frmCategory.Show();
            }
        }
    }
}
