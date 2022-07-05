using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using VisitBosnia.WinUI.Validator;

namespace VisitBosnia.WinUI
{
    public partial class frmLogin : Form
    {
        private readonly APIService appUserService = new APIService("Login");
        private readonly Validation validator;

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
        public frmLogin()
        {
            InitializeComponent();
            validator = new Validation(error);
            txtPassword.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtPassword.Width, txtPassword.Height, 15, 15));
            txtUsername.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, txtUsername.Width, txtUsername.Height, 15, 15));
            btnLogin.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, btnLogin.Width, btnLogin.Height, 15, 15));
            error.BlinkStyle = ErrorBlinkStyle.NeverBlink;
            
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {
            panel1.BackColor = Color.FromArgb(200, 207, 214, 220);
            panel1.Region = Region.FromHrgn(CreateRoundRectRgn(0, 0, panel1.Width, panel1.Height, 30, 30));
            
        }

        

        private void Login_Load(object sender, EventArgs e)
        {
            label1.Parent = panel1;
            label1.BackColor = Color.Transparent;
            btnLogin.FlatStyle = FlatStyle.Flat;
            btnLogin.FlatAppearance.BorderSize = 0;
            label2.Parent = panel1;
            label2.BackColor = Color.Transparent;
            lnkCreateAccount.Parent = panel1;
            lnkCreateAccount.BackColor = Color.Transparent;
            lnkForgotPassword.Parent = panel1;
            lnkForgotPassword.BackColor = Color.Transparent;
            this.ActiveControl = label1;
        }

        private async void btnLogin_Click(object sender, EventArgs e)
        {
            if (ValidateChildren())
            {
                APIService.Username = txtUsername.Text;
                APIService.Password = txtPassword.Text;
                try
                {
                    var result = await appUserService.Login<Model.AppUser>(txtUsername.Text, txtPassword.Text);
                    //dodati provjeru da li je rola admin ili uposlenik
                    if (result != null)
                    {
                        this.Hide();
                        MessageBox.Show("Uspjesna prijava");
                    }
                    else
                    {
                        error.SetError(txtUsername, "Wrong username or password");
                        error.SetError(txtPassword, "Wrong username or password");
                    }
                }
                catch
                {
                    MessageBox.Show("Unexpected error!");
                }
            }
            
        }

        private void lnkCreateAccount_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            var form = new frmRegister();
            form.ShowDialog();
        }

        private void txtUsername_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtUsername, e);
        }

        private void txtPassword_Validating(object sender, CancelEventArgs e)
        {
            validator.RequiredField(txtPassword, e);
        }
    }
}
