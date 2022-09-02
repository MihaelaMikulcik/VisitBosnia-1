using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using VisitBosnia.Services.Interfaces;

namespace VisitBosnia.Security
{
    public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
    {
        public IAppUserService appUserService { get; set; }
        public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger,
            UrlEncoder encoder, ISystemClock clock, IAppUserService appUserService) : base(options, logger, encoder, clock)
        {
            this.appUserService = appUserService;
        }

        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
          
            if (!Request.Headers.ContainsKey("Authorization"))
            {
                return AuthenticateResult.Fail("Missing authentication header");
            }
            var authHeader = AuthenticationHeaderValue.Parse(Request.Headers["Authorization"]);
            var credentialBytes = Convert.FromBase64String(authHeader.Parameter);
            var credentials = Encoding.UTF8.GetString(credentialBytes).Split(':');
            var username = credentials[0];
            var password = credentials[1];

            var user = await appUserService.Login(username, password);

            if (user == null)
                return AuthenticateResult.Fail("Invalid username or password!");

            var claims = new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, username),
                new Claim(ClaimTypes.Name, user.FirstName)
            };

            var identity = new ClaimsIdentity(claims, Scheme.Name);
            var pricipal = new ClaimsPrincipal(identity);
            var ticket = new AuthenticationTicket(pricipal, Scheme.Name);

            return AuthenticateResult.Success(ticket);
        }
    }
}
