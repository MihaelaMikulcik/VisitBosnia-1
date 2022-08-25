using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;

namespace VisitBosnia.Filters
{
    public class ExceptionFilter : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            if (context.Exception is UserException exception)
            {
                context.ModelState.AddModelError("message", context.Exception.Message);
                context.ModelState.AddModelError("responseCode", ((int)HttpStatusCode.BadRequest).ToString());

                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;


            }
            else
            {
                context.ModelState.AddModelError("message", "Server error!");
                context.ModelState.AddModelError("responseCode", ((int)HttpStatusCode.InternalServerError).ToString());

                context.HttpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;

            }

            var list = context.ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, y => string.Join(" ", y.Value.Errors.Select(z => z.ErrorMessage)));
            //var list = context.ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, y => y.Value.Errors.Select(z => z.ErrorMessage));
            context.Result = new JsonResult(list);
        }

    }
}
