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
using VisitBosnia.Model.SearchObjects;
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.WinUI.Events
{
    public partial class frmEvent : Form
    {
        public APIService EventService { get; set; } = new APIService("Event");
        public APIService AppUserFavouriteService { get; set; } = new APIService("AppUserFavourite");
        public APIService EventOrderService { get; set; } = new APIService("EventOrder");
        public APIService ReviewService { get; set; } = new APIService("Review");
        public APIService TouristFacilityService { get; set; } = new APIService("TouristFacility");
        public APIService TouristFacilityGalleryService { get; set; } = new APIService("TouristFacilityGallery");
        private int _agencyId;

        public frmEvent(int agencyId)
        {
            InitializeComponent();
            dgvEvent.AutoGenerateColumns = false;
            _agencyId = agencyId;
            LoadTable();
        }

        private async void LoadTable()
        {
            var searchObject = new EventSearchObject();
            searchObject.IncludeIdNavigation = true;
            searchObject.AgencyId = _agencyId;

            var events = await EventService.Get<Model.Event>(searchObject);

            var list = new List<EventViewModel>();

            foreach (var item in events)
            {

                list.Add(new EventViewModel
                {
                    Id = item.Id,
                    City = item.IdNavigation.City.Name,
                    Category = item.IdNavigation.Category.Name,
                    Name = item.IdNavigation.Name,
                    Date = item.Date.ToShortDateString()
                }) ;
            }

            dgvEvent.DataSource = list;
          
        }

        private async void btn_search_Click(object sender, EventArgs e)
        {
            var searchObject = new EventSearchObject();
            searchObject.SearchText = txtSearch.Text;
            searchObject.IncludeIdNavigation = true;

            var events = await EventService.Get<Model.Event>(searchObject);

            var list = new List<EventViewModel>();

            foreach (var item in events)
            {

                list.Add(new EventViewModel
                {
                    Id = item.Id,
                    City = item.IdNavigation.City.Name,
                    Category = item.IdNavigation.Category.Name,
                    Name = item.IdNavigation.Name,
                    Date = item.Date.ToShortDateString()
                });
            }

            dgvEvent.DataSource = list;
        }

        private void labelBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmEventDetails(_agencyId);
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }

        private async void dgvEvent_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvEvent.Rows[e.RowIndex];
            var item = row.DataBoundItem as EventViewModel;
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn &&
                e.ColumnIndex == 4)
            {

                var favorite = await AppUserFavouriteService.Get<AppUserFavourite>(new AppUserFavouriteSearchObject { TouristFacilityId = item.Id });
                var review = await ReviewService.Get<Model.Review>(new ReviewSearchObject { FacilityId = item.Id });
                var order = await EventOrderService.Get<EventOrder>(new EventOrderSearchObject { EventId = item.Id });

                if(favorite.Count() != 0 || review.Count() != 0 || order.Count() != 0)
                {
                    MessageBox.Show("This event is already in use", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return;
                }

                var confirmResult = MessageBox.Show("Are you sure to delete this item ??",
                                        "Confirm Delete!!",
                                        MessageBoxButtons.YesNo);

                if (confirmResult == DialogResult.Yes)
                {
                    var gallery = await TouristFacilityGalleryService.Get<TouristFacilityGallery>(new TouristFacilityGallerySearchObject { FacilityId = item.Id });

                    foreach(var image in gallery)
                    {
                        await TouristFacilityGalleryService.Delete<TouristFacilityGallery>(image.Id);
                    }

                    var delete = await EventService.Delete<Model.Event>(item.Id);
                    var deleteFacility = await TouristFacilityService.Delete<Model.TouristFacility>(item.Id);
                    LoadTable();
                    var message = MessageBox.Show("Successfully deleted");

                }
              

            }
            else
            {
                if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.ColumnIndex == 5)
                {
                    this.Hide();
                    var form2 = new frmEventDetails(_agencyId,item.Id);
                    form2.Closed += (s, args) => this.Close();
                    form2.Show();

                }
                else
                {
                    
                    var form2 = new frmFacilityGallery(item.Id);
            
                    form2.Show();
                }
            }
        }
    }
}
