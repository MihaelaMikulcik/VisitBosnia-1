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

        public frmAgencyDetails(int id = 0)
        {
            InitializeComponent();
            LoadData(id);
            validator = new Validator.Validation(errorProvider);
        }

        private async void LoadData(int id)
        {
            var cities = await CityService.Get<Model.City>();
            var itemsCity = new List<ComboItem>();
            itemsCity.Add(new ComboItem { Id = -1, Text = "Select a city"});
            //cmbCity.SelectedIndex = -1;

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
                txtPhone.Text = _model.Phone;
                txtAdress.Text = _model.Address;
                txtEmail.Text = _model.Email;
                txtResponsiblePerson.Text = _model.ResponsiblePerson;
                cmbCity.SelectedValue = _model.CityId;
            }

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
                        Phone = txtPhone.Text, 
                        Email = txtEmail.Text, 
                        Address = txtAdress.Text, 
                        ResponsiblePerson = txtResponsiblePerson.Text,
                        CityId = (int)cmbCity.SelectedValue
                        
                    };
                    var newAgency = await AgencyService.Insert<Model.Agency>(agencyInsertRequest);
                }
                else
                {
                    var agencyUpdateRequest = new AgencyUpdateRequest
                    {
                        Name = txtName.Text,
                        Phone = txtPhone.Text,
                        Email = txtEmail.Text,
                        Address = txtAdress.Text,
                        ResponsiblePerson = txtResponsiblePerson.Text,
                        CityId = (int)cmbCity.SelectedValue

                    };
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
