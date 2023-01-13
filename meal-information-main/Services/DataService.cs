using MealInformation.Models;
using MealInformation.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace MealInformation.Services
{
    public class DataService
    {
        private readonly GibzDbContext _dbContext;
        public DataService(GibzDbContext dbContext)
        {
            _dbContext = dbContext;
        }

        /// <summary>
        /// Gets a Day object for a given date from the database.
        /// </summary>
        /// <param name="date">The date of the Day.</param>
        public async Task<Day?> GetDay(DateTime date)
        {
            var daysMeal = await _dbContext.Days.FirstOrDefaultAsync(d => d.Date.Date == date.Date);
            return daysMeal;
        }

        /// <summary>
        /// Adds a Day and Icons to the database if they don't exist already
        /// </summary>
        /// <param name="day">The day to add</param>
        /// <returns>The added Day</returns>
        public async Task<Day> PersistDay(Day day)
        {
            foreach (var menu in day.Menus)
            {
                if (menu.Icons != null)
                {
                    await PersistIcons(menu);
                }
            }

            await _dbContext.Days.AddAsync(day);
            await _dbContext.SaveChangesAsync();

            return day;
        }

        private async Task PersistIcons(Menu menu)
        {
            var persistedIcons = new List<Icon>();
            foreach (var icon in menu.Icons)
            {
                var dbIcon = await _dbContext.Icons.FirstOrDefaultAsync(i => i.AltText == icon.AltText);

                if (dbIcon is null)
                {
                    await _dbContext.Icons.AddAsync(icon);
                    await _dbContext.SaveChangesAsync();
                    dbIcon = icon;
                }

                persistedIcons.Add(dbIcon);
            }

            menu.Icons = persistedIcons;
        }
    }
}