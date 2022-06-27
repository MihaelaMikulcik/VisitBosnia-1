using Flurl.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;

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
    
        public async Task<T> Get<T>(object request = null)
        {
            var url = $"{_endpoint}{_route}";
            if (request != null)
            {
                url += "?";
                url += await request.ToQueryString();
            }
            var result = await url
                .WithBasicAuth(Username, Password)
                .GetJsonAsync<T>();
            return result;
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
            var result = await url
                .WithBasicAuth(Username, Password)
                .PostJsonAsync(request).ReceiveJson<T>();
            return result;
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

        public async Task<T> Register<T>(object request)
        {
            
            var url = $"{_endpoint}{_route}".AllowAnyHttpStatus();
            var result = await url.WithHeader("Authorization", "Basic")
                .PostJsonAsync(request).ReceiveJson<T>();
            return result;


        }
    }
}
