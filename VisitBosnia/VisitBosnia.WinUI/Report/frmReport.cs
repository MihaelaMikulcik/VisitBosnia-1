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
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;

namespace VisitBosnia.WinUI.Report
{
    public partial class frmReport : Form
    {
        private DateTime? _dateFrom = null;
        private DateTime? _dateTo = null;
        private int _agencyId;

        public APIService EventService { get; set; } = new APIService("Event");
        public APIService EventOrderService { get; set; } = new APIService("EventOrder");

        public frmReport(int agencyId)
        {
            InitializeComponent();
            //reportViewer1 = new ReportViewer { ProcessingMode = ProcessingMode.Local };
            _agencyId = agencyId;
                 
        }

        private void frmReport_Load(object sender, EventArgs e)
        {
            dtpFrom.Value = DateTime.Today;
            dtpTo.Value = DateTime.Today;

        }

        private async void btn_search_Click(object sender, EventArgs e)
        {
            var dateFrom = new DateTime(dtpFrom.Value.Year, dtpFrom.Value.Month, dtpFrom.Value.Day, 0, 0, 0);
            var dateTo = new DateTime(dtpTo.Value.Year, dtpTo.Value.Month, dtpTo.Value.Day, 23, 59, 59);

            reportViewer1.Reset();
            reportViewer1.LocalReport.DataSources.Clear();

            if (dateFrom <= dateTo)
            {
                var searchObject = new EventSearchObject();
                searchObject.IncludeIdNavigation = true;
                searchObject.AgencyId = _agencyId;

                var events = await EventService.Get<Model.Event>(searchObject);
                if (events != null)
                {

                    var finalEvents = events.Where(x => x.Date >= dateFrom && x.Date <= dateTo);


                    dsSales.TblOrdersDataTable tbl = new dsSales.TblOrdersDataTable();

                    decimal finalTotal = 0;

                    _dateFrom = dateFrom;
                    _dateTo = dateTo;

                    var rowList = new List<dsSales.TblOrdersRow>();

                    if (finalEvents.ToList().Count > 0)
                    {


                        foreach (var ev in finalEvents.ToList())
                        {
                            var orders = await EventOrderService.Get<Model.EventOrder>(new EventOrderSearchObject { EventId = ev.Id });
                            var sales = 0;
                            var tickets = 0;
                            decimal total = 0;

                            dsSales.TblOrdersRow row = tbl.NewTblOrdersRow();

                            foreach (var ord in orders.ToList())
                            {
                                sales++;
                                tickets += ord.Quantity;
                                total += ord.Price;
                            }

                            row.Name = ev.IdNavigation.Name;
                            row.Price = ev.PricePerPerson;
                            row.NumberOfSales = sales;
                            row.NumberOfTickets = tickets;
                            row.Amount = total;


                           rowList.Add(row);


                            finalTotal += total;

                            
                        }
                   

                        if(topFive.Checked)
                        {
                            foreach(var row in rowList.OrderByDescending(x=> x.Amount).Take(5))
                            {
                                tbl.Rows.Add(row);
                            }
                        }
                        else
                        {
                            foreach (var row in rowList)
                            {
                                tbl.Rows.Add(row);
                            }
                        }

                        ReportParameterCollection parameters = new ReportParameterCollection {
                    new ReportParameter("DateFrom", _dateFrom.ToString()),
                    new ReportParameter("DateTo", _dateTo.ToString()),
                    new ReportParameter("Total", finalTotal.ToString())
                };

                        ReportDataSource rds = new ReportDataSource();
                        rds.Name = "dsSales";
                        rds.Value = tbl;

                    

                        this.reportViewer1.LocalReport.ReportEmbeddedResource = "VisitBosnia.WinUI.Report.AgencyReport.rdlc";
                        this.reportViewer1.LocalReport.SetParameters(parameters);
                        reportViewer1.LocalReport.DataSources.Add(rds);

                        this.reportViewer1.RefreshReport();
                    }
                    else
                    {
                        MessageBox.Show("No data to show!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);

                        reportViewer1.Reset();
                        reportViewer1.LocalReport.DataSources.Clear();
                    }

                }
                else
                {
                    MessageBox.Show("No data to show!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);

                    reportViewer1.Reset();
                    reportViewer1.LocalReport.DataSources.Clear();
                }
            }
            else if (dateFrom > dateTo)
            {
                MessageBox.Show("Wrong input", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);

            }
        }

        private void dtpFrom_ValueChanged(object sender, EventArgs e)
        {
            dtpTo.MinDate = dtpFrom.Value;
        }

        private void dtpTo_ValueChanged(object sender, EventArgs e)
        {
            dtpFrom.MaxDate = dtpTo.Value;
        }

        private void label1_Click(object sender, EventArgs e)
        {

            this.reportViewer1.LocalReport.ReportEmbeddedResource = "VisitBosnia.WinUI.Report.Report.rdlc";

            this.reportViewer1.RefreshReport();
        }

        private void label4_Click(object sender, EventArgs e)
        {
            this.Hide();
            this.Close();
        }
    }
}
