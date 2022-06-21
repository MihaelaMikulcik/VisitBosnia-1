using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;

namespace VisitBosnia.Services.Interfaces
{
    public interface ICityService : ICRUDService<City, CitySearchObject, CityInsertRequest, CityUpdateRequest>
    {
    }
}
