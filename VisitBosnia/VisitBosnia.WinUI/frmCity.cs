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
        }

        private void frmCity_Load(object sender, System.EventArgs e)
        {
            LoadTable();
        }

        private async Task LoadTable()
        {
            var searchObject = new CitySearchObject();

            var list =await CityService.Get<List<City>>();

            dgvCity.DataSource = list;
        }

        private void btn_search_Click(object sender, EventArgs e)
        {
            var searchObject = new CitySearchObject();
            searchObject.Name = txtSearch.Text;
            var list = CityService.Get<List<City>>(searchObject);

            dgvCity.DataSource = list;

        }
    }
}
