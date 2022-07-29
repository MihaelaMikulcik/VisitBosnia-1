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

namespace VisitBosnia.WinUI.Users
{
    public partial class frmUsers : Form
    {

        private readonly APIService appUserService = new APIService("AppUser");

        public frmUsers()
        {
            InitializeComponent();
            dgvUsers.AutoGenerateColumns = false;

            LoadTable();

        }

        private void label1_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }


        private async void LoadTable()
        {
            var list = await appUserService.Get<Model.AppUser>();

            dgvUsers.DataSource = list;
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            var searchObject = new AppUserSearchObject();
            searchObject.SearchText = textSearch.Text;
      
            var list = await appUserService.Get<Model.AppUser>(searchObject);

            dgvUsers.DataSource = list;
        }

        private async void dgvUsers_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvUsers.Rows[e.RowIndex];
            var item = row.DataBoundItem as AppUser;
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewCheckBoxColumn)
            {
                var updateRequest = new Model.Requests.AppUserUpdateRequest
                {
                    IsBlocked = !item.IsBlocked,
                    FirstName = item.FirstName,
                    LastName = item.LastName,
                    UserName = item.UserName,
                    Phone = item.Phone
                };

                var updatedCity = await appUserService.Update<AppUser>(item.Id, updateRequest);

                if(item.IsBlocked)
                {
                    MessageBox.Show("User is no longer blocked");
                }
                else
                {

                MessageBox.Show("User is blocked");
                }

                LoadTable();
            }
        }
    }
}
