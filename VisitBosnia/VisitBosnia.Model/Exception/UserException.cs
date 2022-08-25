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

    }
}
