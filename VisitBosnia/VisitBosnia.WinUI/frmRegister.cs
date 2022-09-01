using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.Filters;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.WinUI.Helpers;
using VisitBosnia.WinUI.Properties;
using VisitBosnia.WinUI.Validator;

namespace VisitBosnia.WinUI
{
    public partial class frmRegister : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService appUserRoleService = new APIService("AppUserRole");
        private readonly APIService agencyMemberService = new APIService("AgencyMember");
        private readonly APIService agencyService = new APIService("Agency");
        private readonly APIService roleService = new APIService("Role");
        private readonly Validator.Validation validator; 

        public frmRegister()
        {
            InitializeComponent();
            validator = new Validator.Validation(error);
            var dtpInfo = new ToolTip();
            dtpInfo.ToolTipIcon = ToolTipIcon.Info;
            dtpInfo.IsBalloon = true;
            dtpInfo.ShowAlways = true;
            dtpInfo.SetToolTip(dtpDateOfBirth, "Please choose the date of your birth");
            error.BlinkStyle = ErrorBlinkStyle.NeverBlink;


        }

        private async void Register_Load(object sender, EventArgs e)
        {
            btnChooseImage.FlatStyle = FlatStyle.Flat;
            btnChooseImage.FlatAppearance.BorderSize = 0;
            btnRegister.FlatStyle = FlatStyle.Flat;
            btnRegister.FlatAppearance.BorderSize = 0;
            pbProfilePicture.Image = Resources.user;
            pbProfilePicture.Tag = "temp_user";
            this.ActiveControl = label1;

            var items = new List<ComboItem>();

            var agency = await agencyService.GetWithoutAuth<Agency>();

            foreach (var ag in agency)
            {
                items.Add(new ComboItem
                {
                    Id = ag.Id,
                    Text = ag.Name
                });
            }

            cbAgency.DataSource = items;
            cbAgency.ValueMember = "Id";
            cbAgency.DisplayMember = "Text";
        }



        private async void btnRegister_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                try
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
                        DateOfBirth = dtpDateOfBirth.Value,
                        IsBlocked = false
                    };
                    if ((string)pbProfilePicture.Tag != "temp_user")
                        request.Image = Helpers.ImageHelper.imageToByteArray(pbProfilePicture.Image);
                    var result = await appUserService.Register(request);
                    if (result != null)
                    {
                        APIService.Username = request.UserName;
                        APIService.Password = request.Password;

                        var roles = await roleService.Get<Role>();
                        var userrole = await appUserRoleService.Insert<AppUserRole>(new AppUserRoleInsertRequest { RoleId = roles.Where(x => x.Name == "Agency").FirstOrDefault().Id, AppUserId = result.Id });
                        var agencyId = (int)cbAgency.SelectedValue;
                        var agencyMember = await agencyMemberService.Insert<AgencyMember>(new AgencyMemberInsertRequest { AppUserId = result.Id, AgencyId = agencyId });

                        MessageBox.Show("Uspješna registracija", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        
                        this.Hide();
                        Application.OpenForms[0].Hide();
                        var form = new AgencyHome(result.Id);
                        form.ShowDialog();
                        
                       
                    }
                    
                }
                catch(Exception ex)
                {
                    if(ex is UserException)
                    {
                        MessageBox.Show(ex.Message);
                    }
                    MessageBox.Show("Neuspjesna registracija");
                }
                
            }
            
        }

        private void btnChooseImage_Click(object sender, EventArgs e)
        {
            if(fileDialog.ShowDialog() == DialogResult.OK)
            {
                pbProfilePicture.Image = Image.FromFile(fileDialog.FileName);
                pbProfilePicture.Tag = "user_image";
            }
        }

        private void txtFirstName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtFirstName, e);
        }

        private void txtLastName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtLastName, e);

        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            validator.EmailValidation(txtEmail, e);

        }

        private void txtUsername_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtUsername, e);
        }

        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtPassword, e);
        }

        private void txtConfirmPass_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtConfirmPass, e);
        }

        private void txtPhone_Validating(object sender, CancelEventArgs e)
        {
            validator.PhoneValidation(txtPhone, e);

        }

        private void cbAgency_Validating(object sender, CancelEventArgs e)
        {
            if (cbAgency.SelectedItem == null )
            {
                e.Cancel = true;
                cbAgency.Focus();
                error.SetError(cbAgency, "Must be selected");
            }
            else
            {
                e.Cancel = false;
                error.SetError(cbAgency, "");
            }
        }
    }
}
