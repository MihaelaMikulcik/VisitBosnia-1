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


        public frmEventDetails(int agnecyId, Model.Event model = null)
        {
            InitializeComponent();
            _agencyId = agnecyId;

            _model = model;
                LoadData();


        }

        private async void LoadData()
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

            if (_model != null)
            {
                txtName.Text = _model.Name;
                txtPleace.Text = _model.PlaceOfDeparture;
                numberPrice.Value = _model.PricePerPerson;
                dtpDate.Value = _model.Date;
                txtFrom.Text = (_model.FromTime/60).ToString() + ":" + (_model.FromTime % 60).ToString();
                txtTo.Text = (_model.ToTime / 60).ToString() + ":" + (_model.ToTime % 60).ToString();
                numberMax.Value = _model.MaxNumberOfParticipants;

                cbCity.SelectedIndex = cbCity.Items.IndexOf(_model.CityId);
                cbGuide.SelectedIndex = cbGuide.Items.IndexOf(_model.AgencyMemberId);
                cbCategory.SelectedIndex = cbCategory.Items.IndexOf(_model.CategoryId);

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

                   var newFacility = await TouristFacilityService.Insert<Event>(facilityInsertRequest);

                    var fromH = txtFrom.Text.Substring(0, txtFrom.Text.IndexOf(":"));
                    var fromM = txtFrom.Text.Substring(txtFrom.Text.IndexOf(":") + 1);
                    var toH = txtTo.Text.Substring(0, txtTo.Text.IndexOf(":"));
                    var toM = txtTo.Text.Substring(txtTo.Text.IndexOf(":") + 1);

                    var insertRequest = new Model.Requests.EventInsertRequest
                    {
                        AgencyId = _agencyId,
                        PlaceOfDeparture = txtPleace.Text,
                        AgencyMemberId =(int)cbGuide.SelectedValue,
                        FromTime = int.Parse(fromH) * 60 + int.Parse(fromM),
                        ToTime = int.Parse(toH) * 60 + int.Parse(toM),
                        PricePerPerson=numberPrice.Value,
                        MaxNumberOfParticipants=(int)numberMax.Value,
                        IdNavigation = newFacility.Id
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
                    var fromH = txtFrom.Text.Substring(0, txtFrom.Text.IndexOf(":"));
                    var fromM = txtFrom.Text.Substring(0, txtFrom.Text.IndexOf(":"));
                    var toH = txtTo.Text.Substring(0, txtTo.Text.IndexOf(":"));
                    var toM = txtTo.Text.Substring(0, txtTo.Text.IndexOf(":"));

                    var updateRequest = new Model.Requests.EventUpdateRequest
                    {
                        Name = txtName.Text,
                        AgencyId = _agencyId,
                        PlaceOfDeparture = txtPleace.Text,
                        Description = txtDescription.Text,
                        AgencyMemberId = (int)cbGuide.SelectedValue,
                        CategoryId = (int)cbCity.SelectedValue,
                        FromTime = int.Parse(fromH) * 60 + int.Parse(fromM),
                        ToTime = int.Parse(toH) * 60 + int.Parse(toM),
                        PricePerPerson = numberPrice.Value,
                        MaxNumberOfParticipants = (int)numberMax.Value,

                    };

                    var updatedCity = await EventService.Update<Event>(_model.Id, updateRequest);
                }

                //MessageBox.Show("Saved successfuly");
                //this.Hide();
                //var form2 = new frmEvent(_agencyId);
                //form2.Closed += (s, args) => this.Close();
                //form2.Show();
            }
        }
    }
}
