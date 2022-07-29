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

namespace VisitBosnia.WinUI.Events
{
    public partial class frmEvent : Form
    {
        public APIService EventService { get; set; } = new APIService("Event");
        private int _agencyId;

        public frmEvent(int agencyId)
        {
            InitializeComponent();
            dgvEvent.AutoGenerateColumns = false;
            LoadTable();
            _agencyId = agencyId;
        }

        private async void LoadTable()
        {
            var searchObject = new EventSearchObject();
            searchObject.IncludeCategory = true;
            searchObject.IncludeCity = true;

            var list = await EventService.Get<Model.Event>(searchObject);

            dgvEvent.DataSource = list;
          
        }

        private async void btn_search_Click(object sender, EventArgs e)
        {
            var searchObject = new EventSearchObject();
            searchObject.SearchText = txtSearch.Text;
            searchObject.IncludeCategory = true;
            searchObject.IncludeCity = true;

            var list = await EventService.Get<Model.Event>(searchObject);

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
            var item = row.DataBoundItem as Model.Event;
            var senderGrid = (DataGridView)sender;

            if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn &&
                e.ColumnIndex == 4)
            {
                var confirmResult = MessageBox.Show("Are you sure to delete this item ??",
                                        "Confirm Delete!!",
                                        MessageBoxButtons.YesNo);

                if (confirmResult == DialogResult.Yes)
                {
                    var delete = await EventService.Delete<Model.Event>(item.Id);
                    LoadTable();
                    var message = MessageBox.Show("Successfully deleted");

                }
              

            }
            else
            {
                if (senderGrid.Columns[e.ColumnIndex] is DataGridViewButtonColumn && e.ColumnIndex == 5)
                {
                    this.Hide();
                    var form2 = new frmEventDetails(_agencyId,item);
                    form2.Closed += (s, args) => this.Close();
                    form2.Show();

                }
                else
                {
                    this.Hide();
                    var form2 = new frmEventGallery(item.Id);
                    form2.Closed += (s, args) => this.Close();
                    form2.Show();
                }
            }
        }
    }
}
