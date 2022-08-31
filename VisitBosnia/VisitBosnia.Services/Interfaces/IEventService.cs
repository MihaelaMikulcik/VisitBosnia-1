﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using VisitBosnia.Model;
using VisitBosnia.Model.Requests;

namespace VisitBosnia.Services.Interfaces
{
    public interface IEventService : ICRUDService<Event, EventSearchObject, EventInsertRequest, EventUpdateRequest>
    {
        public int GetNumberOfParticipants(int eventId);
        public bool IsAvailableEvent(int eventId, int newParticipants);
        public bool isValidDate(int eventId);
    }
}
