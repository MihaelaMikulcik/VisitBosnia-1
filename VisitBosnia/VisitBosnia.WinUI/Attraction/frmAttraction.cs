﻿using System;
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
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Model.ViewModels;
using VisitBosnia.WinUI.Events;

namespace VisitBosnia.WinUI.Attraction
{
    public partial class frmAttraction : Form
    {
        public APIService AttractionService { get; set; } = new APIService("Attraction");
        public APIService TouristFacilityService { get; set; } = new APIService("TouristFacility");
        public APIService ReviewService { get; set; } = new APIService("Review");
        public APIService AppUserFavouriteService { get; set; } = new APIService("AppUserFavourite");
        public APIService TouristFacilityGalleryService { get; set; } = new APIService("TouristFacilityGallery");

        public frmAttraction()
        {
            InitializeComponent();
            dgvAttraction.AutoGenerateColumns = false;
            LoadTable();
        }

        private async void LoadTable()
        {
            var searchObject = new AttractionSearchObject();
            searchObject.IncludeIdNavigation = true;
            var attractions = await AttractionService.Get<Model.Attraction>(searchObject);
            var list = new List<AttractionViewModel>();

            foreach (var item in attractions)
            {

                list.Add(new AttractionViewModel
                {
                    Id = item.Id,
                    City = item.IdNavigation.City.Name,
                    Category = item.IdNavigation.Category.Name,
                    Name = item.IdNavigation.Name,
                });
            }

            dgvAttraction.DataSource = list;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            this.Hide();
            var formDetails = new frmAttractionDetails();
            formDetails.Closed += (s, args) => this.Close();
            formDetails.Show();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {

            var searchObject = new AttractionSearchObject();
            searchObject.SearchText = txtSearch.Text;
            searchObject.IncludeIdNavigation = true;

            var attractions = await AttractionService.Get<Model.Attraction>(searchObject);

            var list = new List<AttractionViewModel>();

            foreach (var item in attractions)
            {

                list.Add(new AttractionViewModel
                {
                    Id = item.Id,
                    City = item.IdNavigation.City.Name,
                    Category = item.IdNavigation.Category.Name,
                    Name = item.IdNavigation.Name,
                });
            }

            dgvAttraction.DataSource = list;
        }

        private async void dgvAttraction_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvAttraction.Rows[e.RowIndex];
            var item = row.DataBoundItem as AttractionViewModel;
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn &&
                e.ColumnIndex == 3)
            {
                var confirmResult = MessageBox.Show("Are you sure to delete this item ??",
                                        "Confirm Delete!!",
                                        MessageBoxButtons.YesNo);

                var favorite = await AppUserFavouriteService.Get<AppUserFavourite>(new AppUserFavouriteSearchObject { TouristFacilityId = item.Id });
                var review = await ReviewService.Get<Model.Review>(new ReviewSearchObject { FacilityId = item.Id });
               

                if (favorite.Count() != 0 || review.Count() != 0 )
                {
                    MessageBox.Show("This attraction is already in use", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return;
                }



                if (confirmResult == DialogResult.Yes)
                {
                    var gallery = await TouristFacilityGalleryService.Get<TouristFacilityGallery>(new TouristFacilityGallerySearchObject { FacilityId = item.Id });

                    foreach (var image in gallery)
                    {
                        await TouristFacilityGalleryService.Delete<TouristFacilityGallery>(image.Id);
                    }

                    var delete = await AttractionService.Delete<Model.Attraction>(item.Id);
                    var deleteFacility = await TouristFacilityService.Delete<Model.TouristFacility>(item.Id);
                    LoadTable();
                    var message = MessageBox.Show("Successfully deleted");

                }


            }
            else
            {
                if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.ColumnIndex == 4)
                {
                    this.Hide();
                    var frmAttraction = new frmAttractionDetails(item.Id);
                    frmAttraction.Closed += (s, args) => this.Close();
                    frmAttraction.Show();

                }
                else
                {

                    var form2 = new frmFacilityGallery(item.Id);
                    form2.Show();
                }
            }
        }

        private void labelBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }
    }
}
