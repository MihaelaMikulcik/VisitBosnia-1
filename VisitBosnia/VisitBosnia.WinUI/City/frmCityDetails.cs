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
        public APIService ForumService { get; set; } = new APIService("Forum");




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
            btnSave.Text = _model != null ? "Change" : "Save";
            pbPicture.Tag = "not_changed";

            if (_model != null)
            {
                txtName.Text = _model.Name;
                txtZipCode.Text = _model.ZipCode;
                txtCounty.Text = _model.County;

            if(_model.Image != null || _model.Image.Length > 0)
            {
                pbPicture.Image = Helpers.ImageHelper.byteArrayToImage(_model.Image);
            }
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {

            if (ValidateChildren())
            {
                if (pbPicture == null || pbPicture.Image == null)
                {
                    MessageBox.Show("Image box is empty", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    return;
                }

                if (_model == null)
                {
                    var insertRequest = new Model.Requests.CityInsertRequest
                    {
                        Name = txtName.Text,
                        County = txtCounty.Text,
                        ZipCode = txtZipCode.Text
                    };

                    if ((string)pbPicture.Tag == "city_image")
                        insertRequest.Image = Helpers.ImageHelper.imageToByteArray(pbPicture.Image);

                    var newCity = await CityService.Insert<City>(insertRequest);

                    var forumInsertRequest = new Model.Requests.ForumInsertRequest
                    {
                        Title = newCity.Name + " Forum",
                        CityId = newCity.Id,
                        CreatedTime = DateTime.Now
                    };

                    var newForum = await ForumService.Insert<Forum>(forumInsertRequest);
                }
                else
                {
                    var updateRequest = new Model.Requests.CityUpdateRequest
                    {
                        Name = txtName.Text,
                        County = txtCounty.Text,
                        ZipCode = txtZipCode.Text
                    };

                    if ((string)pbPicture.Tag == "city_image")
                        updateRequest.Image = Helpers.ImageHelper.imageToByteArray(pbPicture.Image);

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

        private void btnChooseImage_Click(object sender, EventArgs e)
        {
            if (ofdNewImage.ShowDialog() == DialogResult.OK)
            {
                pbPicture.Image = Image.FromFile(ofdNewImage.FileName);
                pbPicture.Tag = "city_image";
            }
        }

        private void txtCounty_TextChanged(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void pbPicture_Validating(object sender, CancelEventArgs e)
        {
            if (pbPicture == null || pbPicture.Image == null)
            {
                e.Cancel = true;
                pbPicture.Focus();
                errorProvider.SetError(pbPicture, "Add image");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(pbPicture, "");
            }
        }
    }
}
