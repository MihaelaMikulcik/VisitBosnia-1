using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using VisitBosnia.WinUI.Agencies;
using VisitBosnia.WinUI.ApplicationUser;
using VisitBosnia.WinUI.Attraction;
using VisitBosnia.WinUI.Categories;
using VisitBosnia.WinUI.Users;

namespace VisitBosnia.WinUI
{
    public partial class AdminHome : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private Model.AppUser _appUser { get; set; }

        public AdminHome(int UserId)
        {
            InitializeComponent();

            LoadUser(UserId);      
        }

        private async void LoadUser(int Id)
        {
            _appUser =await appUserService.GetById<Model.AppUser>(Id);

            if (_appUser.Image.Length > 0)
            {
                pbProfilePicture.Image = ByteToImage(_appUser.Image);
            }

            labelUserName.Text = _appUser.UserName;
        }

        private Bitmap ByteToImage(byte[] blob)
        {
            MemoryStream mStream = new MemoryStream();
            byte[] pData = blob;
            mStream.Write(pData, 0, Convert.ToInt32(pData.Length));
            Bitmap bm = new Bitmap(mStream, false);
            mStream.Dispose();
            return bm;
        }

        private void btnCities_Click(object sender, EventArgs e)
        {
            var form2 = new frmCity();
            form2.Show();
        }

        private void btnUsers_Click(object sender, EventArgs e)
        {
            var form2 = new frmUsers();
            form2.Show();
        }

        private void btnCategories_Click(object sender, EventArgs e)
        {
            var frmCategories = new frmCategory();
            frmCategories.Show();
        }

        private void btnAttractions_Click(object sender, EventArgs e)
        {
            var frmAttractions = new frmAttraction();
            frmAttractions.Show();
        }

        private void btnAgencies_Click(object sender, EventArgs e)
        {
            var frmAgencies = new frmAgency();
            frmAgencies.Show();
        }


        private void btnProfile_Click(object sender, EventArgs e)
        {
            this.Hide();
            var frmProfile = new frmUserProfile(_appUser.Id);
            frmProfile.Closed += (s, args) => this.Close();
            frmProfile.Show();
        }

        private void btnSingOut_Click(object sender, EventArgs e)
        {
            this.Close();
            var formLogin = new frmLogin();
            formLogin.Show();
        }
    }
}
