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
    public partial class frmAgencyMemberDetails : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
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

                AppUserInsertRequest request = new AppUserInsertRequest()
                {
                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,
                    Email = txtEmail.Text,
                    UserName = txtUsername.Text,
                    Phone = txtPhone.Text,
                    Password = txtPassword.Text,
                    PasswordConfirm = txtConfirmPass.Text,
                    IsBlocked = false
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

        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                e.Cancel = true;
                txtPassword.Focus();
                errorProvider.SetError(txtPassword, "Password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtPassword, "");
            }
        }

        private void txtConfirmPass_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtPassword.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                e.Cancel = true;
                txtConfirmPass.Focus();
                errorProvider.SetError(txtConfirmPass, "Passwords should not be left blank!");

            }
            else
            {
                if (txtPassword.Text != txtConfirmPass.Text)
                {
                    e.Cancel = true;
                    txtConfirmPass.Focus();
                    errorProvider.SetError(txtConfirmPass, "Passwords dont match");
                }
                else
                {
                    e.Cancel = false;
                    errorProvider.SetError(txtConfirmPass, "");
                }
            }
        }
    }
}
