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

namespace VisitBosnia.WinUI
{
    public partial class frmCity : Form
    {
        public APIService CityService { get; set; } = new APIService("City");
        public APIService ForumService { get; set; } = new APIService("Forum");


        public frmCity()
        {
            InitializeComponent();
            dgvCity.AutoGenerateColumns = false;
            LoadTable();

        }

      
        private async void LoadTable()
        {        
            var list = await CityService.Get<Model.City>();

            dgvCity.DataSource = list;
        }

        private async void btn_search_Click(object sender, EventArgs e)
        {
            var searchObject = new CitySearchObject();
            searchObject.SearchText = txtSearch.Text;
       
            var list = await CityService.Get<Model.City>(searchObject);

            dgvCity.DataSource = list;

        }

        private void labelBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();

        }

        private async void dgvCity_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvCity.Rows[e.RowIndex];
            var item = row.DataBoundItem as City;
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn &&
                e.ColumnIndex == 4)
            {
                this.Hide();
                var form2 = new frmCityDetails(item);
                form2.Closed += (s, args) => this.Close();
                form2.Show();

            }
            else
            {
                if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn)
                {
                    var confirmResult = MessageBox.Show("Are you sure to delete this item ??",
                                         "Confirm Delete!!",
                                         MessageBoxButtons.YesNo);

                    if (confirmResult == DialogResult.Yes)
                    {
                        try
                        {
                            var forumSearchObj = new ForumSearchObject { CityId = item.Id };
                            var forumFilter = await ForumService.Get<Model.Forum>(forumSearchObj);
                            var forum = forumFilter.FirstOrDefault();
                            if (forum != null)
                            {
                                var deleteForum = ForumService.Delete<Model.Forum>(forum.Id);
                            }
                            var delete = await CityService.Delete<Model.City>(item.Id);
                            LoadTable();
                            var message = MessageBox.Show("Successfully deleted");
                        }
                        catch
                        {
                            MessageBox.Show("This city is already in use", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                     

                    }

                }
            }

          
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmCityDetails();
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }

    }
}
