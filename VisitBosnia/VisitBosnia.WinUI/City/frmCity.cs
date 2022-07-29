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

namespace VisitBosnia.WinUI
{
    public partial class frmCity : Form
    {
        public APIService CityService { get; set; } = new APIService("City");


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
                        var delete = await CityService.Delete<Model.City>(item.Id);
                        LoadTable();
                        var message = MessageBox.Show("Successfully deleted");

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

        private void txtSearch_TextChanged(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
    }
}
