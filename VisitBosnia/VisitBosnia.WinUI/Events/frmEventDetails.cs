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

namespace VisitBosnia.WinUI.Events
{
    public partial class frmEventDetails : Form
    {
        private Model.Event _model = null;
       
        private int _agencyId;

        public APIService EventService { get; set; } = new APIService("Event");
        public APIService CityService { get; set; } = new APIService("City");
        public APIService TouristFacilityService { get; set; } = new APIService("TouristFacility");
        public APIService GuideService { get; set; } = new APIService("AgencyMember");
        public APIService AppUserService { get; set; } = new APIService("AppUser");
        public APIService CategoryService { get; set; } = new APIService("Category");


        public frmEventDetails(int agnecyId, int id = 0)
        {
            InitializeComponent();
            _agencyId = agnecyId;

            LoadData(id);

        }

        private async void LoadData(int id)
        {
            var categories = await CategoryService.Get<Category>();

            var itemsC = new List<ComboItem>();

            foreach(var category in categories)
            {
                itemsC.Add(new ComboItem
                {
                    Id = category.Id,
                    Text = category.Name
                });
            }

            cbCategory.DataSource = itemsC;
            cbCategory.ValueMember = "Id";
            cbCategory.DisplayMember = "Text";

            var guides = await GuideService.Get<AgencyMember>(new AgencyMemberSearchObject { AgencyId = _agencyId});

            var itemsG = new List<ComboItem>();

            foreach (var guide in guides)
            {
                var user = await AppUserService.GetById<AppUser>(guide.AppUserId);

                itemsG.Add(new ComboItem
                {
                    Id = guide.Id,
                    Text = user.FirstName + user.LastName
                });
            }

            cbGuide.DataSource = itemsG;
            cbGuide.ValueMember = "Id";
            cbGuide.DisplayMember = "Text";

            var cities = await CityService.Get<City>();

            var itemsCity = new List<ComboItem>();

            foreach (var city in cities)
            {
                itemsCity.Add(new ComboItem
                {
                    Id = city.Id,
                    Text = city.Name
                });
            }

            cbCity.DataSource = itemsCity;
            cbCity.ValueMember = "Id";
            cbCity.DisplayMember = "Text";

            if (id != 0)
            {

                _model = await EventService.GetById<Event>(id);
                txtName.Text = _model.IdNavigation.Name;
                txtPleace.Text = _model.PlaceOfDeparture;
                numberPrice.Value = _model.PricePerPerson;
                dtpDate.Value = _model.Date;
                nFromH.Value = _model.FromTime / 60;
                nFromM.Value = _model.FromTime % 60;
                nToH.Value = _model.ToTime / 60;
                nToM.Value = _model.ToTime % 60;
                numberMax.Value = _model.MaxNumberOfParticipants;

                cbCity.SelectedValue = _model.IdNavigation.CityId;
                cbGuide.SelectedValue =_model.AgencyMemberId;
                cbCategory.SelectedValue = _model.IdNavigation.CategoryId;

                txtDescription.Text = _model.IdNavigation.Description;

            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmEvent(_agencyId);
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                if (_model == null)
                {
                    var facilityInsertRequest = new TouristFacilityInsertRequest
                    {
                        CategoryId = (int)cbCategory.SelectedValue,
                        Description = txtDescription.Text,
                        Name = txtName.Text,
                        CityId = (int)cbCity.SelectedValue
                    };

                   var newFacility = await TouristFacilityService.Insert<TouristFacility>(facilityInsertRequest);

   
                    var insertRequest = new Model.Requests.EventInsertRequest
                    {
                        AgencyId = _agencyId,
                        PlaceOfDeparture = txtPleace.Text,
                        AgencyMemberId =(int)cbGuide.SelectedValue,
                        FromTime = (int)nFromH.Value * 60 + (int)nFromM.Value,
                        ToTime = (int)nToH.Value * 60 + (int)nToM.Value,
                        PricePerPerson=numberPrice.Value,
                        MaxNumberOfParticipants=(int)numberMax.Value,
                        Id = newFacility.Id,
                        Date = dtpDate.Value
                    };

                    try
                    {

                     await EventService.Insert<Event>(insertRequest);

                    }
                    catch(Exception ex)
                    {
                        var message = ex.Message;
                    }
                }
                else
                {
                    var facilityUpdateRequest = new TouristFacilityUpdateRequest
                    {
                        CategoryId = (int)cbCategory.SelectedValue,
                        Description = txtDescription.Text,
                        Name = txtName.Text,
                        CityId = (int)cbCity.SelectedValue
                    };

                    await TouristFacilityService.Update<TouristFacility>(_model.Id, facilityUpdateRequest);
                 

                    var updateRequest = new Model.Requests.EventUpdateRequest
                    {
                        Name = txtName.Text,
                        AgencyId = _agencyId,
                        PlaceOfDeparture = txtPleace.Text,
                        Description = txtDescription.Text,
                        AgencyMemberId = (int)cbGuide.SelectedValue,
                        CategoryId = (int)cbCity.SelectedValue,
                        FromTime = (int)nFromH.Value * 60 + (int)nFromM.Value,
                        ToTime = (int)nToH.Value * 60 + (int)nToM.Value,
                        PricePerPerson = numberPrice.Value,
                        MaxNumberOfParticipants = (int)numberMax.Value,
                        Date = dtpDate.Value
                    };

                    var updatedCity = await EventService.Update<Event>(_model.Id, updateRequest);
                }

                this.Hide();
                var form2 = new frmEvent(_agencyId);
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

        private void txtPleace_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPleace.Text))
            {
                e.Cancel = true;
                txtPleace.Focus();
                errorProvider.SetError(txtPleace, "Pleace should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtPleace, "");
            }
        }

        private void nFromH_Validating(object sender, CancelEventArgs e)
        {
            if (nFromH.Value == 0 || nFromH.Value > 24 || nFromH.Value < 0 )
            {
                e.Cancel = true;
                nFromH.Focus();
                errorProvider.SetError(nFromH, "Invalid hour");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(nFromH, "");
            }
        }

        private void nToH_Validating(object sender, CancelEventArgs e)
        {
            if (nToH.Value == 0 || nToH.Value > 24 || nToH.Value < 0)
            {
                e.Cancel = true;
                nToH.Focus();
                errorProvider.SetError(nToH, "Invalid hour");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(nToH, "");
            }
        }

        private void nFromM_Validating(object sender, CancelEventArgs e)
        {
            if (nFromM.Value > 59 || nFromM.Value < 0)
            {
                e.Cancel = true;
                nToH.Focus();
                errorProvider.SetError(nFromM, "Invalid hour");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(nFromM, "");
            }
        }

        private void nToM_Validating(object sender, CancelEventArgs e)
        {
            if (nToM.Value > 59 || nToM.Value < 0)
            {
                e.Cancel = true;
                nToH.Focus();
                errorProvider.SetError(nToM, "Invalid hour");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(nToM, "");
            }
        }

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void numberPrice_Validating(object sender, CancelEventArgs e)
        {
            if (numberPrice.Value == 0 )
            {
                e.Cancel = true;
                numberPrice.Focus();
                errorProvider.SetError(numberPrice, "Add price");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(numberPrice, "");
            }
        }

        private void numberMax_Validating(object sender, CancelEventArgs e)
        {
            if (numberMax.Value == 0)
            {
                e.Cancel = true;
                numberMax.Focus();
                errorProvider.SetError(numberMax, "Add number");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(numberMax, "");
            }
        }
    }
}
