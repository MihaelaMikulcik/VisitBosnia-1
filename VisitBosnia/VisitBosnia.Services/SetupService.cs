using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Services.Database;

namespace VisitBosnia.Services
{
    public class SetupService
    {

        private VisitBosniaContext context;

        public SetupService(VisitBosniaContext _context)
        {
            context = _context;
        }

        public void Init()
         {
            if (!context.Roles.Any() && !context.AppUserRoles.Any() && !context.AppUsers.Any())
            {

                var path = Path.Combine(Directory.GetCurrentDirectory(), "script.sql");
                var query = File.ReadAllText(path);
                context.Database.ExecuteSqlRaw(query);
            }
        }
    }
}
