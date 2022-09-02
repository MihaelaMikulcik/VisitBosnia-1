using Flurl.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.ViewModels;

namespace VisitBosnia.WinUI
{
    public class APIService
    {
        private string _route = null;
        private string _endpoint = Properties.Settings.Default.ApiURL;
        public static string Username { get; set; }
        public static string Password { get; set; }
        public APIService(string route)
        {
            _route = route;
        }

        public async Task<IEnumerable<T>> Get<T>(object request = null)
        {
            var url = $"{_endpoint}{_route}";
            if (request != null)
            {
                url += "?";
                url += await request.ToQueryString();
            }

            return await url
            .WithBasicAuth(Username, Password)
            .GetJsonAsync<IEnumerable<T>>();
        }

        public async Task<IEnumerable<T>> GetWithoutAuth<T>(object request = null)
        {
            var url = $"{_endpoint}{_route}";
            if (request != null)
            {
                url += "?";
                url += await request.ToQueryString();
            }

            return await url
            .GetJsonAsync<IEnumerable<T>>();
        }


        public async Task<T> GetById<T>(object id)
        {
            var result = await $"{_endpoint}{_route}/{id}"
                .WithBasicAuth(Username, Password)
                .GetJsonAsync<T>();
            return result;
        }

        public async Task<T> Insert<T>(object request)
        {

            var url = $"{_endpoint}{_route}";
            try
            {
                var result = await url
                    .WithBasicAuth(Username, Password)
                    .PostJsonAsync(request).ReceiveJson<T>();
                return result;
            }
            catch (Exception ex)
            {
                return default(T);
            }

        }

        public async Task<T> Update<T>(int id, object request)
        {
            var url = $"{_endpoint}{_route}/{id}";
            var result = await url
                .WithBasicAuth(Username, Password)
                .PutJsonAsync(request).ReceiveJson<T>();
            return result;
        }

        public async Task<T> Login<T>(string username, string password)
        {
            var url = $"{_endpoint}{_route}?Username={username}&Password={password}";

            var result = await url.WithBasicAuth(username, password).GetJsonAsync<T>();
            return result;

        }

        public async Task<Model.AppUser> Register(AppUserInsertRequest request)
        {
            try
            {
                var url = $"{_endpoint}{_route}/Register";
                return await url.PostJsonAsync(request).ReceiveJson<AppUser>();
            }
            catch (FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string>>();
                if (errors != null)
                {
                    errors.TryGetValue("message", out string message);

                    MessageBox.Show(message, "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                    MessageBox.Show("Došlo je do greške", "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(Model.AppUser);
            }
        }

        public async Task<T> Delete<T>(int id)
        {
            try
            {
                var url = $"{_endpoint}{_route}/delete/{id}";
                return await url.WithBasicAuth(Username, Password).DeleteAsync().ReceiveJson<T>();
            }
            catch (FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string[]>>();

                var stringBuilder = new StringBuilder();
                foreach (var error in errors)
                {
                    stringBuilder.AppendLine($"{error.Key}, ${string.Join(",", error.Value)}");
                }

                MessageBox.Show(stringBuilder.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(T);
            }
        }

        public async Task<int> SendSms(SmsMessage request)
        {
            try
            {
                var url = $"{_endpoint}{_route}/SendSMS";
                return await url.WithBasicAuth(Username, Password).PostJsonAsync(request).ReceiveJson<int>();
            }
            catch (FlurlHttpException ex)
            {
                return default(int);
            }

        }



        public async Task<Model.AppUser> ChangePassword(AppUserChangePasswordRequest request)
        {
            try
            {
                var url = $"{_endpoint}{_route}/ChangePassword";
                return await url.WithBasicAuth(request.Username, request.OldPassword).PostJsonAsync(request).ReceiveJson<AppUser>();
            }
            catch (FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string>>();
                if (errors != null)
                {
                    errors.TryGetValue("message", out string message);

                    MessageBox.Show(message, "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                    MessageBox.Show("Došlo je do greške", "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(Model.AppUser);
            }
        }

        public async Task<Model.AppUser> UpdateUser(int id, AppUserUpdateRequest request)
        {
            try
            {
                var url = $"{_endpoint}{_route}/{id}";
                return await url.WithBasicAuth(Username, Password).PutJsonAsync(request).ReceiveJson<AppUser>();
            }
            catch (FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string>>();
                if (errors != null)
                {
                    errors.TryGetValue("message", out string message);

                    MessageBox.Show(message, "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                else
                    MessageBox.Show("Došlo je do greške", "Greška", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(Model.AppUser);
            }
        }

        public async Task<bool> UsernameExists(string username)
        {
            
            var url = $"{_endpoint}{_route}/UsernameExists?username={username}";
            return await url.WithBasicAuth(Username, Password).GetJsonAsync<bool>();
            
           
        }

        public async Task<bool> EmailExists(string email)
        {
            var url = $"{_endpoint}{_route}/EmailExists?email={email}";
            return await url.WithBasicAuth(Username, Password).GetJsonAsync<bool>();
        }

    }
    
}
