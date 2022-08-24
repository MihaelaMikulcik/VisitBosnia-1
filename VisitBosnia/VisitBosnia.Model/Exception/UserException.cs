using System.Net;
using System.Runtime.Serialization;

namespace VisitBosnia.Filters
{
    [Serializable]
    public class UserException : Exception
    {
        public UserException(string message):base(message)
        {
        }
        
        protected UserException(SerializationInfo info, StreamingContext context):base(info, context) { }

        //public HttpStatusCode StatusCode { get; set; }
        //public UserException(string message, HttpStatusCode statusCode) : base(message)
        //{
        //    this.StatusCode = statusCode;
        //}

        //protected UserException(SerializationInfo info, StreamingContext context) : base(info, context) { }

    }
}
