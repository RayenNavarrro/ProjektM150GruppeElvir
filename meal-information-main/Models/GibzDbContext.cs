using MealInformation.Models.Entities;
using MealInformation.Models.ValueConverters;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace MealInformation.Models
{
    public class GibzDbContext : DbContext
    {
        public DbSet<Day> Days => Set<Day>();
        public DbSet<Menu> Menus => Set<Menu>();
        public DbSet<Icon> Icons => Set<Icon>();
        public DbSet<NutritionalValue> NutritionalValues => Set<NutritionalValue>();
        public DBSet<CoffeCardUser> CoffeCardUser => Set<CoffeCardUser>();

        public GibzDbContext(DbContextOptions<GibzDbContext> options) : base(options) { }

        protected override void ConfigureConventions(ModelConfigurationBuilder configurationBuilder)
        {
            configurationBuilder
                .Properties<ICollection<string>>()
                .HaveConversion<StringListValueConverter, StringListValueComparer>();
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Menu>()
                        .HasMany(menu => menu.Icons)
                        .WithMany(icon => icon.Menus)
                        .UsingEntity(j => j.ToTable("MenuIcons"));

            // modelBuilder.Entity<Menu>()
            //             .Property(menu => menu.MenuComponents)
            //             .HasConversion<StringListValueConverter, StringListValueComparer>();

            modelBuilder.Entity<Day>().Navigation(day => day.Menus).AutoInclude(true);
            modelBuilder.Entity<Menu>().Navigation(menu => menu.Icons).AutoInclude(true);
            modelBuilder.Entity<Menu>().Navigation(menu => menu.NutritionalValues).AutoInclude(true);
        }
    }

    public class GibzDbContextFactory : IDesignTimeDbContextFactory<GibzDbContext>
    {
        public GibzDbContext CreateDbContext(string[] args)
        {
            var optionsBuilder = new DbContextOptionsBuilder<GibzDbContext>();
            string connectionString = "Server=127.0.0.1;Port=13302;Database=mealinformation;User=gibzapp;Password=password";
            ServerVersion serverVersion = new MariaDbServerVersion(new Version(10, 7));
            optionsBuilder.UseMySql(connectionString, serverVersion);

            return new GibzDbContext(optionsBuilder.Options);
        }
    }
}