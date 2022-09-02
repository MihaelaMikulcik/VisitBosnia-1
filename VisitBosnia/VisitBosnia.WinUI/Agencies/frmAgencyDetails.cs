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
using VisitBosnia.Model.Requests;
using VisitBosnia.WinUI.Helpers;

namespace VisitBosnia.WinUI.Agencies
{
    public partial class frmAgencyDetails : Form
    {
        public APIService CityService { get; set; } = new APIService("City");
        public APIService AgencyService { get; set; } = new APIService("Agency");
        private readonly Validator.Validation validator;
        private Agency _model = null;

        public frmAgencyDetails(int id = 0, bool readOnly = false)
        {
            InitializeComponent();
            LoadData(id);
            if (readOnly == true)
            {
                btnSave.Dispose();
                btnCancel.Dispose();
                Button button = new Button();
                this.Controls.Add(button);
                button.Name = "btnBack";
                button.Text = "Back";
                button.BackColor = Color.FromArgb(26, 51, 80);
                button.Size = new System.Drawing.Size(100, 34);
                button.Location = new System.Drawing.Point(46, 399);
                button.ForeColor = Color.White;
                button.FlatStyle = FlatStyle.Popup;
                button.Click += new EventHandler(btnBack_Click);
                txtName.ReadOnly = true;
                txtPhone.ReadOnly = true;
                txtAdress.ReadOnly = true;
                txtResponsiblePerson.ReadOnly = true;
                txtEmail.ReadOnly = true;
                cmbCity.Visible = false;
                City.Visible = false;

            }
            validator = new Validator.Validation(errorProvider);
        }

        private async void LoadData(int id)
        {
            btnSave.Text = id != 0 ? "Change" : "Save";
            var cities = await CityService.Get<Model.City>();
            var itemsCity = new List<ComboItem>();
            itemsCity.Add(new ComboItem { Id = -1, Text = "Select a city"});

            foreach (var city in cities)
            {
                itemsCity.Add(new ComboItem
                {
                    Text = city.Name,
                    Id = city.Id,
                });
            }
            cmbCity.DataSource = itemsCity;
            cmbCity.ValueMember = "Id";
            cmbCity.DisplayMember = "Text";

            if (id != 0)
            {
                _model = await AgencyService.GetById<Model.Agency>(id);
                txtName.Text = _model.Name;
                if (!string.IsNullOrEmpty(_model.Phone))
                    txtPhone.Text = _model.Phone?.Substring(3, _model.Phone.Length - 3);
                txtAdress.Text = _model.Address;
                txtEmail.Text = _model.Email;
                txtResponsiblePerson.Text = _model.ResponsiblePerson;
                cmbCity.SelectedValue = _model.CityId;
            }

        }

        private void btnBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private void txtName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtName, e);
        }

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            validator.PhoneValidation(txtPhone, e);
        }

        private void txtAdress_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtAdress, e);
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            validator.EmailValidation(txtEmail, e);
        }

        private void cmbCity_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(cmbCity, e);
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                if (_model == null)
                {
                    var agencyInsertRequest = new AgencyInsertRequest
                    {
                        Name = txtName.Text,
                        Email = txtEmail.Text, 
                        Address = txtAdress.Text, 
                        ResponsiblePerson = txtResponsiblePerson.Text,
                        CityId = (int)cmbCity.SelectedValue
                        
                    };
                    if (!string.IsNullOrEmpty(txtPhone.Text))
                        agencyInsertRequest.Phone = "387" + txtPhone.Text;
                    var newAgency = await AgencyService.Insert<Model.Agency>(agencyInsertRequest);
                }
                else
                {
                    var agencyUpdateRequest = new AgencyUpdateRequest
                    {
                        Name = txtName.Text,
                        Email = txtEmail.Text,
                        Address = txtAdress.Text,
                        ResponsiblePerson = txtResponsiblePerson.Text,
                        CityId = (int)cmbCity.SelectedValue

                    };
                    if (!string.IsNullOrEmpty(txtPhone.Text))
                        agencyUpdateRequest.Phone = "387" + txtPhone.Text;
                    var updateAgency = await AgencyService.Update<Model.Agency>(_model.Id,agencyUpdateRequest);

                }
                this.Hide();
                var frmAgency = new frmAgency();
                frmAgency.Closed += (s, args) => this.Close();
                frmAgency.Show();
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var frmAgency = new frmAgency();
            frmAgency.Closed += (s, args) => this.Close();
            frmAgency.Show();
        }

        
    }
}
