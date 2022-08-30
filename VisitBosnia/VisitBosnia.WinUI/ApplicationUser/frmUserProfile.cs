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

namespace VisitBosnia.WinUI.ApplicationUser
{
    public partial class frmUserProfile : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService appUserRoleService = new APIService("AppUserRole");
        private readonly APIService RoleService = new APIService("Role");
        private readonly Validator.Validation validator;
        private Model.AppUser _appUser { get; set; }
        private Model.Role _role { get; set; }


        public frmUserProfile(int id)
        {
            InitializeComponent();
            LoadUserData(id);
            validator = new Validator.Validation(errorProvider);
        }

        //private async void LoadUserRole(int id)
        //{
        //    _appUser = await appUserService.GetById<Model.AppUser>(id);
        //    var userRole = await appUserRoleService.Get<Model.AppUserRole>(new AppUserRoleSearchObject { AppUserId = _appUser.Id });
        //    _role = await RoleService.GetById<Model.Role>(userRole.FirstOrDefault().Id);
        //}

        private async void LoadUserData(int id)
        {
            _appUser = await appUserService.GetById<Model.AppUser>(id);
            var userRole = await appUserRoleService.Get<Model.AppUserRole>(new AppUserRoleSearchObject { AppUserId = _appUser.Id });
            _role = await RoleService.GetById<Model.Role>(userRole.FirstOrDefault().Id);
            txtFirstName.Text = _appUser.FirstName;
            txtLastName.Text = _appUser.LastName;
            txtUserName.Text = _appUser.UserName;
            txtPhoneNumber.Text = _appUser.Phone;
            txtEmail.Text = _appUser.Email;
            if(_appUser.Image?.Length>0)
            {
                pbUserPicture.Image = Helpers.ImageHelper.byteArrayToImage(_appUser.Image);
            }
                pbUserPicture.Tag = "user_picture";
        }

        private void btnChangeImage_Click(object sender, EventArgs e)
        {
            if(openFileDialog.ShowDialog() == DialogResult.OK)
            {
                pbUserPicture.Image = Image.FromFile(openFileDialog.FileName);
                pbUserPicture.Tag = "new_picture";
            }
            else
            {
                pbUserPicture.Tag = "user_picture";
            }
        }

        private async void btnCancel_Click(object sender, EventArgs e)
        {
            this.Hide();
            var userRole = await appUserRoleService.Get<Model.AppUserRole>(new AppUserRoleSearchObject { AppUserId = _appUser.Id });
            var role = await RoleService.GetById<Model.Role>(userRole.FirstOrDefault().RoleId);
            if (role.Name == "Admin")
            {
                var frmHome = new AdminHome(_appUser.Id);
                frmHome.Closed += (s, args) => this.Close();
                frmHome.Show();
            }
            else
            {
                var frmHome = new AgencyHome(_appUser.Id);
                frmHome.Closed += (s, args) => this.Close();
                frmHome.Show();
            }

        }

        private async void btnChange_Click(object sender, EventArgs e)
        {
            var updateRequest = new AppUserUpdateRequest
            {
                FirstName = txtFirstName.Text,
                LastName = txtLastName.Text,
                UserName = txtUserName.Text,
                Phone = txtPhoneNumber.Text,
                Email = txtEmail.Text,
                ChangedEmail = txtEmail.Text != _appUser.Email ? true : false,
                ChangedUsername = txtUserName.Text != _appUser.UserName ? true : false,
            };
            if(pbUserPicture.Tag.ToString() == "new_picture" && pbUserPicture.Image != null)
            {
                updateRequest.Image = Helpers.ImageHelper.imageToByteArray(pbUserPicture.Image);
            }
            else if(_appUser.Image?.Length>0)
            {
                updateRequest.Image = _appUser.Image;
            }
            //var updateUser = await appUserService.Update<Model.AppUser>(_appUser.Id, updateRequest);
            var updateUser = await appUserService.UpdateUser(_appUser.Id, updateRequest);
            if (updateUser != null)
            {
                MessageBox.Show("Successfully updated profile data!");
                APIService.Username = updateUser.UserName;
                var userRole = await appUserRoleService.Get<Model.AppUserRole>(new AppUserRoleSearchObject { AppUserId = _appUser.Id });
                var role = await RoleService.GetById<Model.Role>(userRole.FirstOrDefault().RoleId);
                this.Hide();

                if (role.Name == "Admin")
                {
                    var frmHome = new AdminHome(_appUser.Id);
                    frmHome.Closed += (s, args) => this.Close();
                    frmHome.Show();
                }
                else
                {
                    var frmHome = new AgencyHome(_appUser.Id);
                    frmHome.Closed += (s, args) => this.Close();
                    frmHome.Show();
                }

            }

            
           
            //this.Hide();
            //this.Close();
        }

        private void txtFirstName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtFirstName,e);
        }

        private void txtLastName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtLastName, e);
        }

        private void txtUserName_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtUserName, e);
        }

        private void txtPhoneNumber_Validating(object sender, CancelEventArgs e)
        {
            validator.PhoneValidation(txtPhoneNumber, e);
        }

        private void txtEmail_Validating(object sender, CancelEventArgs e)
        {
            validator.EmailValidation(txtEmail, e);
        }
    }
}
