namespace MealInformation.Models.Entities;

public class Icon
{
    public Guid Id { get; set; }
    public string SourceUri { get; set; } = null!;
    public string AltText { get; set; } = null!;
    public ICollection<Menu> Menus { get; set; } = null!;
}