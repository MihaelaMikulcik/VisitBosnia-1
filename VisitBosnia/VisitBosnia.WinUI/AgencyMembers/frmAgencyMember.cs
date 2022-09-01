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

namespace VisitBosnia.WinUI.AgencyMembers
{
    public partial class frmAgencyMember : Form
    {
        private int _agencyId;
        private List<AppUser> _members = null;
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService agencyMemberService = new APIService("AgencyMember");

        public frmAgencyMember(int agnecyId)
        {
            InitializeComponent();
            _agencyId = agnecyId;
            dgvMembers.AutoGenerateColumns = false;

            LoadTable();
        }

        private async void LoadTable()
        {
            var list = new List<AppUser>();
            var members = await agencyMemberService.Get<AgencyMember>(new AgencyMemberSearchObject { AgencyId = _agencyId });

            foreach(var member in members)
            {
                var user = await appUserService.GetById<AppUser>(member.AppUserId);
                list.Add(user);
            }

            _members = list;
            dgvMembers.DataSource = list;
        }

        private void label1_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            var searchText = textSearch.Text.ToLower();
            dgvMembers.DataSource = _members.Where(x => x.FirstName.ToLower().StartsWith(searchText) || x.LastName.ToLower().StartsWith(searchText)).ToList();
        }

        private async void dgvMembers_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var row = dgvMembers.Rows[e.RowIndex];
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
                    Phone = item.Phone,
                    Email = item.Email,
                    Image=item.Image
                };

                var updatedUser = await appUserService.Update<AppUser>(item.Id, updateRequest);

                if (item.IsBlocked)
                {
                    MessageBox.Show("Member is no longer blocked");
                }
                else
                {

                    MessageBox.Show("Member is blocked");
                }

                LoadTable();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmAgencyMemberDetails(_agencyId);
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }
    }
}
