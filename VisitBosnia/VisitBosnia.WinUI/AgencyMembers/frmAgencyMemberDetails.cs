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
using System.Web.Security;

namespace VisitBosnia.WinUI.AgencyMembers
{
    public partial class frmAgencyMemberDetails : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService agencyService = new APIService("Agency");
        private readonly APIService agencyMemberService = new APIService("AgencyMember");
        private int _agencyId;

        public frmAgencyMemberDetails(int agencyId)
        {
            InitializeComponent();
            _agencyId = agencyId;
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form2 = new frmAgencyMember(_agencyId);
            form2.Closed += (s, args) => this.Close();
            form2.Show();
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())//dodati validaciju
            {
                StringBuilder builder = new StringBuilder();
                Random random = new Random();
                char ch;
                for (int i = 0; i < 8; i++)
                {
                    ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                    builder.Append(ch);
                }

                var tempPass = builder.ToString();
                var agencyName = await agencyService.GetById<Agency>(_agencyId);
                appUserService.SendEmail(new SendEmailRequest { Email = txtEmail.Text, AgencyName = agencyName.Name, TempPass = tempPass });

                AppUserInsertRequest request = new AppUserInsertRequest()
                {
                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,
                    Email = txtEmail.Text,
                    UserName = txtUsername.Text,
                    Phone = txtPhone.Text,
                    Password = tempPass,
                    PasswordConfirm = tempPass,
                    IsBlocked = false,
                    TempPass = tempPass
                };

                var result = await appUserService.Register(request);

                if (result != null)
                {

                    var agencyMember = await agencyMemberService.Insert<AgencyMember>(new AgencyMemberInsertRequest { AppUserId = result.Id, AgencyId = _agencyId });

                    this.Hide();
                    var form2 = new frmAgencyMember(_agencyId);
                    form2.Closed += (s, args) => this.Close();
                    form2.Show();


                }


            }
        }

        private void txtFirstName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                e.Cancel = true;
                txtFirstName.Focus();
                errorProvider.SetError(txtFirstName, "First name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtFirstName, "");
            }
        }

        private void txtLastName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {
                e.Cancel = true;
                txtLastName.Focus();
                errorProvider.SetError(txtLastName, "Last name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtLastName, "");
            }
        }

        private void txtUsername_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                e.Cancel = true;
                txtUsername.Focus();
                errorProvider.SetError(txtUsername, "Username should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtUsername, "");
            }
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                e.Cancel = true;
                txtEmail.Focus();
                errorProvider.SetError(txtEmail, "Email should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtEmail, "");
            }
        }

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                e.Cancel = true;
                txtPhone.Focus();
                errorProvider.SetError(txtPhone, "Phone should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtPhone, "");
            }
        }

     
    }
}
