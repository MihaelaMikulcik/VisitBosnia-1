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
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.WinUI.AgencyMembers
{
    public partial class frmAgencyMemberDetails : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService agencyService = new APIService("Agency");
        private readonly APIService agencyMemberService = new APIService("AgencyMember");
        private readonly APIService roleService = new APIService("Role");
        private readonly APIService appUserRoleService = new APIService("AppUserRole");
        private readonly APIService smsService = new APIService("SMS");
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
                try
                {
                    StringBuilder builder = new StringBuilder();
                    Random random = new Random();
                    char ch;
                    for (int i = 0; i < 8; i++)
                    {
                        ch = Convert.ToChar(Convert.ToInt32(Math.Floor(26 * random.NextDouble() + 65)));
                        builder.Append(ch);
                    }

                    var phone = "387" + txtPhone.Text;

                    var tempPass = builder.ToString();
                    var agencyName = await agencyService.GetById<Agency>(_agencyId);
                    string msg = $"{agencyName.Name} added you as a member. Login data: {txtUsername.Text} {tempPass}. Please log in and change password";
                    var smsResult = await smsService.SendSms(new SmsMessage { To = phone, Message = msg, From = "Vonage APIs" });
                    if(smsResult == 200)
                    {
                        AppUserInsertRequest request = new AppUserInsertRequest()
                        {
                            FirstName = txtFirstName.Text,
                            LastName = txtLastName.Text,
                            Email = txtEmail.Text,
                            UserName = txtUsername.Text,
                            Phone = phone,
                            Password = tempPass,
                            PasswordConfirm = tempPass,
                            IsBlocked = true,
                            TempPass = true
                        };

                        var result = await appUserService.Register(request);

                        if (result != null)
                        {

                            var agencyMember = await agencyMemberService.Insert<AgencyMember>(new AgencyMemberInsertRequest { AppUserId = result.Id, AgencyId = _agencyId });

                            var roles = await roleService.Get<Role>();
                            var userrole = await appUserRoleService.Insert<AppUserRole>(new AppUserRoleInsertRequest { RoleId = roles.Where(x => x.Name == "Agency").FirstOrDefault().Id, AppUserId = result.Id });


                            this.Hide();
                            var form2 = new frmAgencyMember(_agencyId);
                            form2.Closed += (s, args) => this.Close();
                            form2.Show();
                            MessageBox.Show("The invitation has been sent", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);


                        }
                    }
                    else
                    {
                        MessageBox.Show("Sorry, new agency member currently can't be added!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }

                   
                }
                catch
                {
                    MessageBox.Show("Something went wrong", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
