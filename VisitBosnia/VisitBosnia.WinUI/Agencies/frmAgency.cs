using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.WinUI.Agencies
{
    public partial class frmAgency : Form
    {
        public APIService AgencyService { get; set; } = new APIService("Agency");

        public frmAgency()
        {
            InitializeComponent();
            dgvAgencies.AutoGenerateColumns = false;
            LoadData();
        }

        private async void LoadData()
        {
            var searchObj = new AgencySearchObject { IncludeCity = true };
            var agencies = await AgencyService.Get<Model.Agency>(searchObj);
            var data = new List<AgencyViewModel>();
            foreach(var agency in agencies)
            {
                data.Add(new AgencyViewModel
                {
                    Id = agency.Id, 
                    Name = agency.Name,
                    Address = agency.Address,
                    Phone = agency.Phone,
                    City =  agency.City.Name,
                    Email = agency.Email,
                    ResponsiblePerson = agency.ResponsiblePerson
                });
            }
            dgvAgencies.DataSource = data;
        }

        private void labelback_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            this.Hide();
            var frmDetails = new frmAgencyDetails();
            frmDetails.Closed += (s, args) => this.Close();
            frmDetails.Show();
        }

        private async void dgvAgencies_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvAgencies.Rows[e.RowIndex];
            var item = row.DataBoundItem as AgencyViewModel;
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.ColumnIndex == 6)
            {
                var confirmResult = MessageBox.Show("Are you sure to delete this item ??",
                                        "Confirm Delete!!",
                                        MessageBoxButtons.YesNo);

                if (confirmResult == DialogResult.Yes)
                {
                    var deleteAgency = await AgencyService.Delete<Model.Agency>(item.Id);
                    LoadData();
                    var message = MessageBox.Show("Successfully deleted");

                }
            }
            else
            {
                if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn)
                {
                    this.Hide();
                    var frmAgencyDetails = new frmAgencyDetails(item.Id);
                    frmAgencyDetails.Closed += (s, args) => this.Close();
                    frmAgencyDetails.Show();
                }
            }
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            var search = new AgencySearchObject
            {
                IncludeCity = true,
                SearchText = txtSearch.Text
            };
            var agencies = await AgencyService.Get<Model.Agency>(search);
            var data = new List<AgencyViewModel>();
            foreach (var agency in agencies)
            {
                data.Add(new AgencyViewModel
                {
                    Id = agency.Id,
                    Name = agency.Name,
                    Address = agency.Address,
                    Phone = agency.Phone,
                    City = agency.City.Name,
                    Email = agency.Email,
                    ResponsiblePerson = agency.ResponsiblePerson
                });
            }
            dgvAgencies.DataSource = data;
        }
    }
}
