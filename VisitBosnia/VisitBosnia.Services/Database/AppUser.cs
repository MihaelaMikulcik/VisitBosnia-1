using System;
using System.Collections.Generic;

namespace VisitBosnia.Services.Database
{
    public partial class AppUser
    {
        public AppUser()
        {
            AgencyMembers = new HashSet<AgencyMember>();
            AppUserFavourites = new HashSet<AppUserFavourite>();
            AppUserRoles = new HashSet<AppUserRole>();
            EventOrders = new HashSet<EventOrder>();
            PostReplies = new HashSet<PostReply>();
            Posts = new HashSet<Post>();
            Reviews = new HashSet<Review>();
        }

        public int Id { get; set; }
        public string FirstName { get; set; } = null!;
        public string LastName { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string? Phone { get; set; }
        public string UserName { get; set; } = null!;
        public string PasswordHash { get; set; } = null!;
        public string PasswordSalt { get; set; } = null!;
        public byte[]? Image { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public bool IsBlocked { get; set; }

        public virtual ICollection<AgencyMember> AgencyMembers { get; set; }
        public virtual ICollection<AppUserFavourite> AppUserFavourites { get; set; }
        public virtual ICollection<AppUserRole> AppUserRoles { get; set; }
        public virtual ICollection<EventOrder> EventOrders { get; set; }
        public virtual ICollection<PostReply> PostReplies { get; set; }
        public virtual ICollection<Post> Posts { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
    }
}
