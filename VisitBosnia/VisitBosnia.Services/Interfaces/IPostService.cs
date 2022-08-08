using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;
using VisitBosnia.Model.SearchObjects;

namespace VisitBosnia.Services.Interfaces
{
    public interface IPostService : ICRUDService<Post, PostSearchObject, PostInsertRequest, object>
    {
    }
}
