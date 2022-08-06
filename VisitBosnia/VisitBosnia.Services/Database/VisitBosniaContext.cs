using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace VisitBosnia.Services.Database
{
    public partial class VisitBosniaContext : DbContext
    {
        public VisitBosniaContext()
        {
        }

        public VisitBosniaContext(DbContextOptions<VisitBosniaContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Agency> Agencies { get; set; } = null!;
        public virtual DbSet<AgencyMember> AgencyMembers { get; set; } = null!;
        public virtual DbSet<AppUser> AppUsers { get; set; } = null!;
        public virtual DbSet<AppUserFavourite> AppUserFavourites { get; set; } = null!;
        public virtual DbSet<AppUserRole> AppUserRoles { get; set; } = null!;
        public virtual DbSet<Attraction> Attractions { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<City> Cities { get; set; } = null!;
        public virtual DbSet<Event> Events { get; set; } = null!;
        public virtual DbSet<EventOrder> EventOrders { get; set; } = null!;
        public virtual DbSet<Forum> Forums { get; set; } = null!;
        public virtual DbSet<Post> Posts { get; set; } = null!;
        public virtual DbSet<PostReply> PostReplies { get; set; } = null!;
        public virtual DbSet<Review> Reviews { get; set; } = null!;
        public virtual DbSet<ReviewGallery> ReviewGalleries { get; set; } = null!;
        public virtual DbSet<Role> Roles { get; set; } = null!;
        public virtual DbSet<TouristFacility> TouristFacilities { get; set; } = null!;
        public virtual DbSet<TouristFacilityGallery> TouristFacilityGalleries { get; set; } = null!;
        public virtual DbSet<Transaction> Transactions { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Server=.;Database=VisitBosnia2;Trusted_Connection=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Agency>(entity =>
            {
                entity.ToTable("Agency");

                entity.HasIndex(e => e.CityId, "IX_Agency_CityId");

                entity.HasOne(d => d.City)
                    .WithMany(p => p.Agencies)
                    .HasForeignKey(d => d.CityId);
            });

            modelBuilder.Entity<AgencyMember>(entity =>
            {
                entity.ToTable("AgencyMember");

                entity.HasOne(d => d.Agency)
                    .WithMany(p => p.AgencyMembers)
                    .HasForeignKey(d => d.AgencyId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AgencyMemberAgency");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.AgencyMembers)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AgencyMemberAppUser");
            });

            modelBuilder.Entity<AppUser>(entity =>
            {
                entity.ToTable("AppUser");

                entity.Property(e => e.DateOfBirth).HasColumnType("datetime");

                entity.Property(e => e.Email).HasMaxLength(255);

                entity.Property(e => e.FirstName).HasMaxLength(255);

                entity.Property(e => e.LastName).HasMaxLength(255);

                entity.Property(e => e.PasswordHash).HasMaxLength(255);

                entity.Property(e => e.PasswordSalt).HasMaxLength(255);

                entity.Property(e => e.Phone).HasMaxLength(255);

                entity.Property(e => e.UserName).HasMaxLength(255);
            });

            modelBuilder.Entity<AppUserFavourite>(entity =>
            {
                entity.ToTable("AppUserFavourite");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.AppUserFavourites)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AppUserFavouriteAppUser");

                entity.HasOne(d => d.TouristFacility)
                    .WithMany(p => p.AppUserFavourites)
                    .HasForeignKey(d => d.TouristFacilityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AppUserFavouriteTouristFacility");
            });

            modelBuilder.Entity<AppUserRole>(entity =>
            {
                entity.ToTable("AppUserRole");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.AppUserRoles)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AppUserRoleAppUser");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AppUserRoles)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_AppUserRoleRole");
            });

            modelBuilder.Entity<Attraction>(entity =>
            {
                entity.ToTable("Attraction");

                entity.Property(e => e.Id).ValueGeneratedNever();
                entity.Property(e => e.GeoLat).HasColumnType("decimal(10, 6)");
                entity.Property(e => e.GeoLong).HasColumnType("decimal(10, 6)");


                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.Attraction)
                    .HasForeignKey<Attraction>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");
            });

            modelBuilder.Entity<City>(entity =>
            {
                entity.ToTable("City");
            });

            modelBuilder.Entity<Event>(entity =>
            {
                entity.ToTable("Event");

                entity.HasIndex(e => e.AgencyId, "IX_Event_AgencyId");

                entity.Property(e => e.Id).ValueGeneratedNever();

                entity.Property(e => e.PricePerPerson).HasColumnType("decimal(18, 2)");

                entity.HasOne(d => d.Agency)
                    .WithMany(p => p.Events)
                    .HasForeignKey(d => d.AgencyId);

                entity.HasOne(d => d.AgencyMember)
                    .WithMany(p => p.Events)
                    .HasForeignKey(d => d.AgencyMemberId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_EventAgencyMember");

                entity.HasOne(d => d.IdNavigation)
                    .WithOne(p => p.Event)
                    .HasForeignKey<Event>(d => d.Id)
                    .OnDelete(DeleteBehavior.ClientSetNull);
            });

            modelBuilder.Entity<EventOrder>(entity =>
            {
                entity.ToTable("EventOrder");

                entity.Property(e => e.Price).HasColumnType("decimal(18, 0)");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.EventOrders)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_EventOrderAppUser");

                entity.HasOne(d => d.Event)
                    .WithMany(p => p.EventOrders)
                    .HasForeignKey(d => d.EventId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_EventOrderEvent");
            });

            modelBuilder.Entity<Forum>(entity =>
            {
                entity.ToTable("Forum");

                entity.Property(e => e.CreatedTime).HasColumnType("datetime");

                entity.Property(e => e.Description).HasMaxLength(255);

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.Forums)
                    .HasForeignKey(d => d.CityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ForumCity");
            });

            modelBuilder.Entity<Post>(entity =>
            {
                entity.ToTable("Post");

                entity.Property(e => e.Content).HasMaxLength(255);

                entity.Property(e => e.CreatedTime).HasColumnType("datetime");

                entity.Property(e => e.Title).HasMaxLength(255);

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.Posts)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostAppUser");

                entity.HasOne(d => d.Forum)
                    .WithMany(p => p.Posts)
                    .HasForeignKey(d => d.ForumId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostForum");
            });

            modelBuilder.Entity<PostReply>(entity =>
            {
                entity.ToTable("PostReply");

                entity.Property(e => e.Content).HasMaxLength(255);

                entity.Property(e => e.CreatedTime).HasColumnType("datetime");

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.PostReplies)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostReplyAppUser");

                entity.HasOne(d => d.Post)
                    .WithMany(p => p.PostReplies)
                    .HasForeignKey(d => d.PostId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_PostReplyPost");
            });

            modelBuilder.Entity<Review>(entity =>
            {
                entity.ToTable("Review");

                entity.Property(e => e.Text).HasMaxLength(255);

                entity.HasOne(d => d.AppUser)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.AppUserId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReviewAppUser");

                entity.HasOne(d => d.TouristFacility)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.TouristFacilityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReviewTouristFacility");
            });

            modelBuilder.Entity<ReviewGallery>(entity =>
            {
                entity.ToTable("ReviewGallery");

                entity.Property(e => e.ImageType).HasMaxLength(255);

                entity.HasOne(d => d.Review)
                    .WithMany(p => p.ReviewGalleries)
                    .HasForeignKey(d => d.ReviewId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_ReviewGalleryReview");
            });

            modelBuilder.Entity<Role>(entity =>
            {
                entity.ToTable("Role");

                entity.Property(e => e.Description)
                    .HasMaxLength(255)
                    .IsUnicode(false);

                entity.Property(e => e.Name)
                    .HasMaxLength(255)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<TouristFacility>(entity =>
            {
                entity.ToTable("TouristFacility");

                entity.HasIndex(e => e.CategoryId, "IX_TouristFacility_CategoryId");

                entity.HasIndex(e => e.CityId, "IX_TouristFacility_CityId");

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.TouristFacilities)
                    .HasForeignKey(d => d.CategoryId);

                entity.HasOne(d => d.City)
                    .WithMany(p => p.TouristFacilities)
                    .HasForeignKey(d => d.CityId);
            });

            modelBuilder.Entity<TouristFacilityGallery>(entity =>
            {
                entity.ToTable("TouristFacilityGallery");

                entity.Property(e => e.ImageType).HasMaxLength(255);

                entity.HasOne(d => d.TouristFacility)
                    .WithMany(p => p.TouristFacilityGalleries)
                    .HasForeignKey(d => d.TouristFacilityId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_TouristFacilityGalleryTouristFacility");
            });

            modelBuilder.Entity<Transaction>(entity =>
            {
                entity.Property(e => e.Date).HasColumnType("datetime");

                entity.Property(e => e.Status).HasMaxLength(255);

                entity.HasOne(d => d.EventOrder)
                    .WithMany(p => p.Transactions)
                    .HasForeignKey(d => d.EventOrderId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_TransactionsEventOrder");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
