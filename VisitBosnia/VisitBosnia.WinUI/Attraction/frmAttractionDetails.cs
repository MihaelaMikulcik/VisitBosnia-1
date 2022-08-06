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

namespace VisitBosnia.WinUI.Attraction
{
    public partial class frmAttractionDetails : Form
    {
        private Model.Attraction _model = null;

        public APIService CityService { get; set; } = new APIService("City");
        public APIService CategoryService { get; set; } = new APIService("Category");
        public APIService AttractionService { get; set; } = new APIService("Attraction");
        public APIService TouristFacilityService { get; set; } = new APIService("TouristFacility");


        public frmAttractionDetails(int id = 0)
        {
            InitializeComponent();
            LoadData(id);
        }

        private async void LoadData(int id)
        {
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

            cmbCity.DataSource = itemsCity;
            cmbCity.ValueMember = "Id";
            cmbCity.DisplayMember = "Text";

            var categories = await CategoryService.Get<Category>();

            var itemsCategory = new List<ComboItem>();

            foreach (var category in categories)
            {
                itemsCategory.Add(new ComboItem
                {
                    Id = category.Id,
                    Text = category.Name
                });
            }

            cmbCategory.DataSource = itemsCategory;
            cmbCategory.ValueMember = "Id";
            cmbCategory.DisplayMember = "Text";

            if (id != 0)
            {
                _model = await AttractionService.GetById<Model.Attraction>(id);
                txtName.Text = _model.IdNavigation.Name;
                numLatitude.Value =_model.GeoLat;
                numLongitude.Value = _model.GeoLong;
                txtDescription.Text = _model.IdNavigation.Description;
                cmbCity.SelectedValue = _model.IdNavigation.CityId;
                cmbCategory.SelectedValue = _model.IdNavigation.CategoryId;
            }
        }

        private void frmAttractionDetails_Load(object sender, EventArgs e)
        {

        }

        private void btnCancel_Click(object sender, EventArgs e)
        {

            this.Hide();
            var frmAttraction = new frmAttraction();
            frmAttraction.Closed += (s, args) => this.Close();
            frmAttraction.Show();
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

        private void txtLatitude_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(numLatitude.Text))
            {
                e.Cancel = true;
                txtName.Focus();
                errorProvider.SetError(numLatitude, "Latitude should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(numLatitude, "");
            }

        }

        private void txtLongitude_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(numLongitude.Text))
            {
                e.Cancel = true;
                txtName.Focus();
                errorProvider.SetError(numLongitude, "Longitude should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(numLongitude, "");
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                if (_model == null)
                {
                    var facilityInsertRequest = new TouristFacilityInsertRequest
                    {
                        CategoryId = (int)cmbCategory.SelectedValue,
                        Description = txtDescription.Text,
                        Name = txtName.Text,
                        CityId = (int)cmbCity.SelectedValue
                    };

                    var newFacility = await TouristFacilityService.Insert<TouristFacility>(facilityInsertRequest);

                    var insertRequest = new Model.Requests.AttractionInsertRequest
                    {
                        Id = newFacility.Id,
                        GeoLat = numLatitude.Value,
                        GeoLong = numLongitude.Value
                    };

                    try
                    {
                        await AttractionService.Insert<Model.Attraction>(insertRequest);
                    }
                    catch (Exception ex)
                    {
                        var message = ex.Message;
                    }
                }
                else
                {

                    var facilityUpdateRequest = new TouristFacilityUpdateRequest
                    {
                        CategoryId = (int)cmbCategory.SelectedValue,
                        Description = txtDescription.Text,
                        Name = txtName.Text,
                        CityId = (int)cmbCity.SelectedValue
                    };

                    await TouristFacilityService.Update<TouristFacility>(_model.Id, facilityUpdateRequest);

                    AttractionUpdateRequest updateRequest = new AttractionUpdateRequest
                    {
                        Name = txtName.Text,
                        Description = txtDescription.Text,
                        GeoLat = numLatitude.Value,
                        GeoLong = numLongitude.Value,
                        CityId = (int)cmbCity.SelectedValue,
                        CategoryId = (int)cmbCategory.SelectedValue
                    };
                    var updatedAttraction = await AttractionService.Update<Model.Attraction>(_model.Id, updateRequest);
                   
                }
                this.Hide();
                var frmAttraction = new frmAttraction();
                frmAttraction.Closed += (s, args) => this.Close();
                frmAttraction.Show();
            }
        }
    }
}
