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
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;

namespace VisitBosnia.WinUI
{
    public partial class Register : Form
    {
        APIService appUserService = new APIService("Register");
        [DllImport("Gdi32.dll", EntryPoint = "CreateRoundRectRgn")]
        private static extern IntPtr CreateRoundRectRgn
        (
            int nLeftRect,     // x-coordinate of upper-left corner
            int nTopRect,      // y-coordinate of upper-left corner
            int nRightRect,    // x-coordinate of lower-right corner
            int nBottomRect,   // y-coordinate of lower-right corner
            int nWidthEllipse, // height of ellipse
            int nHeightEllipse // width of ellipse
        );
        public Register()
        {
            InitializeComponent();
            txtFirstName.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtFirstName.Width, txtFirstName.Height, 15, 15));
            txtLastName.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtLastName.Width, txtLastName.Height, 15, 15));
            txtEmail.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtEmail.Width, txtEmail.Height, 15, 15));
            txtUsername.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtUsername.Width, txtUsername.Height, 15, 15));
            txtPhone.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtPhone.Width, txtPhone.Height, 15, 15));
            txtPassword.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtPassword.Width, txtPassword.Height, 15, 15));
            txtConfirmPass.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtConfirmPass.Width, txtConfirmPass.Height, 15, 15));
            dtpDateOfBirth.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, dtpDateOfBirth.Width, dtpDateOfBirth.Height, 15, 15));
            btnChooseImage.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, btnChooseImage.Width, btnChooseImage.Height, 15, 15));
            btnRegister.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, btnRegister.Width, btnRegister.Height, 15, 15));

        }

        private void Register_Load(object sender, EventArgs e)
        {
            btnChooseImage.FlatStyle = FlatStyle.Flat;
            btnChooseImage.FlatAppearance.BorderSize = 0;
            btnRegister.FlatStyle = FlatStyle.Flat;
            btnRegister.FlatAppearance.BorderSize = 0;

        }

        private async void btnRegister_Click(object sender, EventArgs e)
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
                    DateOfBirth = dtpDateOfBirth.Value,
                    //Image = Helpers.ImageHelper.imageToByteArray(pbProfilePicture.Image)
                };
                if (pbProfilePicture.Image != null)
                    request.Image = Helpers.ImageHelper.imageToByteArray(pbProfilePicture.Image);

                var user = await appUserService.Register<AppUser>(request);
                APIService.Username = request.UserName;
                APIService.Password = request.Password;
                MessageBox.Show("Uspjesna registracija");
            }
            
        }

        
    }
}
