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

namespace VisitBosnia.WinUI.Categories
{
    public partial class frmCategory : Form
    {
        public APIService CategoryService { get; set; } = new APIService("Category");

        public frmCategory()
        {
            InitializeComponent();
            dgvCategories.AutoGenerateColumns = false;
            LoadTable();
        }

        private void frmCategory_Load(object sender, EventArgs e)
        {

        }

        private async void LoadTable()
        {
            var categories = await CategoryService.Get<Model.Category>();
            dgvCategories.DataSource = categories;

        }

        private void labelBack_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private async void btnSearch_Click(object sender, EventArgs e)
        {
            var searchObj = new CategorySearchObject();
            searchObj.SearchText = txtSearch.Text;
            var list = await CategoryService.Get<Model.Category>(searchObj);
            dgvCategories.DataSource = list;
        }

        private async void dgvCategories_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvCategories.Rows[e.RowIndex];
            var item = row.DataBoundItem as Category;
            var senderGrid = (DataGridView)sender;
            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.ColumnIndex == 3)
            {
                this.Hide();
                var frmDetails = new frmCategoryDetails(item);
                frmDetails.Closed += (s, args) => this.Close();
                frmDetails.Show();
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
                        var delete = await CategoryService.Delete<Model.Category>(item.Id);
                        LoadTable();
                        var message = MessageBox.Show("Successfully deleted");
                    }
                }
            }
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            this.Hide();
            var frmDetails = new frmCategoryDetails();
            frmDetails.Closed += (s, args) => this.Close();
            frmDetails.Show();
        }
    }
}
