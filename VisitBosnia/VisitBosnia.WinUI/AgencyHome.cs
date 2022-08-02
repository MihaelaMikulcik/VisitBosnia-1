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
using VisitBosnia.WinUI.AgencyMembers;
using VisitBosnia.WinUI.Events;

namespace VisitBosnia.WinUI
{
    public partial class AgencyHome : Form
    {
        private readonly APIService appUserService = new APIService("AppUser");
        private readonly APIService agencyMemberService = new APIService("AgencyMember");
        private Model.AppUser _appUser { get; set; }

        public AgencyHome(int UserId)
        {
            InitializeComponent();

            LoadUser(UserId);
        }

        private async void LoadUser(int Id)
        {
            _appUser = await appUserService.GetById<Model.AppUser>(Id);

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



        private async void button2_Click(object sender, EventArgs e)
        {
            var agencyId = await agencyMemberService.Get<AgencyMember>(new AgencyMemberSearchObject { AppUserId = _appUser.Id });
            var form2 = new frmEvent(agencyId.FirstOrDefault().AgencyId);
            form2.Show();
        }

        private async void button1_Click(object sender, EventArgs e)
        {
            var agencyId = await agencyMemberService.Get<AgencyMember>(new AgencyMemberSearchObject { AppUserId = _appUser.Id });
            var form2 = new frmAgencyMember(agencyId.FirstOrDefault().AgencyId);
            form2.Show();
        }
    }
}
