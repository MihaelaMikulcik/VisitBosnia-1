using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.WinUI.Review
{
    public partial class frmReview : Form
    {
        public APIService ReviewService { get; set; } = new APIService("Review");
        private int _agencyId;

        public frmReview(int agencyId)
        {
            InitializeComponent();
            dgvReviews.AutoGenerateColumns = false;
            _agencyId = agencyId;
            LoadData();
        }

        private async void LoadData()
        {
            var searchObj = new ReviewSearchObject { 
                AgencyId = _agencyId, 
                IncludeAppUser = true,
                IncludeTouristFacility = true
            };
            var data = await ReviewService.Get<Model.Review>(searchObj);
            var list = new List<ReviewViewModel>();
            foreach (var item in data)
            {
                list.Add(new ReviewViewModel
                {
                    AppUserName = item.AppUser.FirstName + " " + item.AppUser.LastName,
                    TouristFacilityName = item.TouristFacility.Name, 
                    Rating = item.Rating, 
                    Text = item.Text
                });
            }
            dgvReviews.DataSource = list;
        }

        private void labelBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            var searchObj = new ReviewSearchObject
            {
                AgencyId = _agencyId,
                IncludeAppUser = true,
                IncludeTouristFacility = true,
                SearchText = txtSearch.Text
            };
            var data = await ReviewService.Get<Model.Review>(searchObj);
            var list = new List<ReviewViewModel>();
            foreach (var item in data)
            {
                list.Add(new ReviewViewModel
                {
                    AppUserName = item.AppUser.FirstName + " " + item.AppUser.LastName,
                    TouristFacilityName = item.TouristFacility.Name,
                    Rating = item.Rating,
                    Text = item.Text
                });
            }
            dgvReviews.DataSource = list;
        }
    }
}
