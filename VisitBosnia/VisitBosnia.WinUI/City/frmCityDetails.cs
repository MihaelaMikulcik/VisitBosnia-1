using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.Model;

namespace VisitBosnia.WinUI
{
    public partial class frmCityDetails : Form
    {
        private Model.City _model = null;

        public APIService CityService { get; set; } = new APIService("City");



        public frmCityDetails( Model.City model = null)
        {
            InitializeComponent();
            _model = model;
            LoadData();

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmCity();
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }

        private void LoadData()
        {
            if(_model != null)
            {
                txtName.Text = _model.Name;
                txtZipCode.Text = _model.ZipCode;
                txtCounty.Text = _model.County;
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {

            if (ValidateChildren())
            {
                if (_model == null)
                {
                    var insertRequest = new Model.Requests.CityInsertRequest
                    {
                        Name = txtName.Text,
                        County = txtCounty.Text,
                        ZipCode = txtZipCode.Text
                    };

                    var newCity = await CityService.Insert<City>(insertRequest);
                }
                else
                {
                    var updateRequest = new Model.Requests.CityUpdateRequest
                    {
                        Name = txtName.Text,
                        County = txtCounty.Text,
                        ZipCode = txtZipCode.Text
                    };

                    var updatedCity = await CityService.Update<City>(_model.Id, updateRequest);
                }

                MessageBox.Show("Saved successfuly");
                this.Hide();
                var form2 = new frmCity();
                form2.Closed += (s, args) => this.Close();
                form2.Show();
            }

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

        private void txtCounty_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtCounty.Text))
            {
                e.Cancel = true;
                txtCounty.Focus();
                errorProvider.SetError(txtCounty, "County should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtCounty, "");
            }
        }

        private void txtZipCode_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtZipCode.Text))
            {
                e.Cancel = true;
                txtCounty.Focus();
                errorProvider.SetError(txtZipCode, "ZipCode should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtZipCode, "");
            }
        }
    }
}
