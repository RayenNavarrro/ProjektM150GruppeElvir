namespace MealInformation.Models.Entities;

public class Day
{
    public Guid Id { get; set; }
    public DateTime Date { get; set; }
    public ICollection<Menu> Menus { get; set; } = null!;
}