﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace VisitBosnia.Services.Database
{
    public partial class Event 
    {
        public Event()
        {
            EventOrders = new HashSet<EventOrder>();
        }

        [ForeignKey("IdNavigation")]
        public int Id { get; set; }
        public int AgencyId { get; set; }
        public DateTime Date { get; set; }
        public int FromTime { get; set; }
        public int ToTime { get; set; }
        public string PlaceOfDeparture { get; set; } = null!;
        public decimal PricePerPerson { get; set; }
        public int MaxNumberOfParticipants { get; set; }
        public int AgencyMemberId { get; set; }

        public virtual Agency Agency { get; set; } = null!;
        public virtual AgencyMember AgencyMember { get; set; } = null!;
        public virtual TouristFacility IdNavigation { get; set; } = null!;
        public virtual ICollection<EventOrder> EventOrders { get; set; }
    }
}
