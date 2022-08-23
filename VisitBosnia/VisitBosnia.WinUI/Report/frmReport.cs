using Microsoft.Reporting.WinForms;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VisitBosnia.WinUI.Report
{
    public partial class frmReport : Form
    {
        public frmReport(int agencyId)
        {
            InitializeComponent();
            //reportViewer1 = new ReportViewer { ProcessingMode = ProcessingMode.Local };
          
        }

        private void frmReport_Load(object sender, EventArgs e)
        {
     
          
        }

        private void btn_search_Click(object sender, EventArgs e)
        {
            this.reportViewer1.LocalReport.ReportEmbeddedResource = "VisitBosnia.VisitBosnia.WinUI.Report.AgencyReport.rdlc";
            this.reportViewer1.RefreshReport();
        }
    }
}
