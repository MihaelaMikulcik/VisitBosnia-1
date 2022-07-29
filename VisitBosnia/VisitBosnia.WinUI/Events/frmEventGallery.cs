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

namespace VisitBosnia.WinUI.Events
{
    public partial class frmEventGallery : Form
    {
        private List<TouristFacilityGallery> _gallery;
        private int _selectedIndex;
        private int _eventId;

        public APIService TouristFacilityGalleryService { get; set; } = new APIService("TouristFacilityGallery");

        public frmEventGallery(int eventId)
        {
            InitializeComponent();
            _eventId = eventId;
            InitPictures();
        }

        private void btnPrevious_Click(object sender, EventArgs e)
        {
            if (_selectedIndex == 0)
            {
                _selectedIndex = 0;
            }
            else
            {
                _selectedIndex--;
            }

            RenderPicture(_selectedIndex);
        }

        private async void InitPictures()
        {
            var gallery = await TouristFacilityGalleryService.Get<TouristFacilityGallery>(new TouristFacilityGallerySearchObject { EventId = _eventId });
            _gallery = gallery.ToList();

            if (gallery.Count() != 0)
            {
                pbEvent.SizeMode = PictureBoxSizeMode.StretchImage;

                _selectedIndex = gallery.Count() - 1;

                RenderPicture(_selectedIndex);
            }
            else
            {
                pbEvent.Image = null;
                MessageBox.Show("No images to display! You can add some with the 'Add new image' button.");
            }
        }

        private async void RenderPicture(int selectedId)
        {
            ImageConverter converter = new ImageConverter();
            var pictureSource = _gallery[selectedId].Image;
            pbEvent.Image = null;
            pbEvent.Image = (Image)converter.ConvertFrom(pictureSource);
        }

 

        private void btnNext_Click(object sender, EventArgs e)
        {
            if (_selectedIndex == _gallery.Count() - 1)
            {
                _selectedIndex = 0;
            }
            else
            {
                _selectedIndex++;
            }

            RenderPicture(_selectedIndex);
        }

        private void btnNext_Click_1(object sender, EventArgs e)
        {

        }
    }
}
