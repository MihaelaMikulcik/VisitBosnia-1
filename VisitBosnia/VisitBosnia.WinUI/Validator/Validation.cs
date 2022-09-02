using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VisitBosnia.WinUI.Validator
{
    public class Validation
    {
        private readonly ErrorProvider _errorProvider;
        public Validation(ErrorProvider errorProvider)
        {
            _errorProvider = errorProvider;
        }
        public void RequiredField(Control control, CancelEventArgs e)
        {
            if(control is TextBox)
            {
                if (string.IsNullOrWhiteSpace(control.Text))
                {
                    e.Cancel = true;
                    _errorProvider.SetError(control, ErrMessages.RequiredField);
                }
                else
                    _errorProvider.SetError(control, null);
            }
            else if(control is ComboBox)
            {
                if((int)(control as ComboBox).SelectedValue == -1)
                {
                    e.Cancel = true;
                    _errorProvider.SetError(control, ErrMessages.RequiredField);
                }
                else
                    _errorProvider.SetError(control, null);
            }
        }

        public void EmailValidation(TextBox textbox, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textbox.Text))
            {
                e.Cancel = true;
                _errorProvider.SetError(textbox, ErrMessages.RequiredField);
            }
            else
            {
                Regex regex = new Regex(@"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                Match match = regex.Match(textbox.Text);
                if (!match.Success)
                {
                    e.Cancel = true;
                    _errorProvider.SetError(textbox, ErrMessages.WrongEmailFormat);
                }
                else
                    _errorProvider.SetError(textbox, null);

            }
           
        }
        public void PhoneValidation(TextBox textbox, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(textbox.Text))
            {
                e.Cancel = true;
                _errorProvider.SetError(textbox, ErrMessages.RequiredField);
            }
            else
            {
                Regex regex = new Regex(@"^\(?\d{3}\)?-? *\d{3}-? *-?\d{3,4}$");
                //Regex regex = new Regex(@"^387\(?\d{3}\)?-? *\d{3}-? *-?\d{3,4}$");
                Match match = regex.Match(textbox.Text);
                if (!match.Success)
                {
                    e.Cancel = true;
                    _errorProvider.SetError(textbox, ErrMessages.WrongPhoneFormat);
                }
                else
                    _errorProvider.SetError(textbox, null);

            }
        }



    }
}
