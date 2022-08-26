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

namespace VisitBosnia.WinUI
{
    public partial class ChangePassword : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");

        public ChangePassword()
        {
            InitializeComponent();
            this.ActiveControl = label1;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {

                var request = new AppUserChangePasswordRequest
                {
                    Username = txtUsername.Text,
                    OldPassword = textOldPassword.Text,
                    NewPassword = txtPassword.Text,
                    NewPasswordConfirm = txtConfirmPass.Text
                };

                try
                {
                    await appUserService.ChangePassword(request);

                    MessageBox.Show("You have successfuly changed your password", "Success", MessageBoxButtons.OK, MessageBoxIcon.None);

                    this.Hide();
                    var form = new frmLogin();
                    form.ShowDialog();

                }
                catch
                {

                }
        } }

        private void txtUsername_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {
                e.Cancel = true;
                txtUsername.Focus();
                error.SetError(txtUsername, "UserName should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                error.SetError(txtUsername, "");
            }
        }

        private void textOldPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textOldPassword.Text))
            {
                e.Cancel = true;
                textOldPassword.Focus();
                error.SetError(textOldPassword, "Old password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                error.SetError(textOldPassword, "");
            }
        }

        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textOldPassword.Text))
            {
                e.Cancel = true;
                txtPassword.Focus();
                error.SetError(txtPassword, "Password should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                error.SetError(txtPassword, "");
            }
        }

        private void txtConfirmPass_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtConfirmPass.Text))
            {


                e.Cancel = true;
                txtConfirmPass.Focus();
                error.SetError(txtConfirmPass, "Password should not be left blank!");

            }
            else
            {
                if (txtConfirmPass.Text != txtPassword.Text)
                {

                    e.Cancel = true;
                    txtConfirmPass.Focus();
                    error.SetError(txtConfirmPass, "Passwords doesn't match");
                }
                else

                {
                    e.Cancel = false;
                    error.SetError(txtConfirmPass, "");
                }
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var form = new frmLogin();
            form.ShowDialog();
        }
    }
}
