using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Drawing.Drawing2D;

namespace VisitBosnia.WinUI.CustomInput
{
    public class Picture:PictureBox
    {
        protected override void OnPaint(PaintEventArgs pe)
        {
            GraphicsPath grapphicsPath = new GraphicsPath();
            grapphicsPath.AddEllipse(0, 0, ClientSize.Width, ClientSize.Height);
            this.Region = new System.Drawing.Region(grapphicsPath);
            base.OnPaint(pe);
        }
    }
}
