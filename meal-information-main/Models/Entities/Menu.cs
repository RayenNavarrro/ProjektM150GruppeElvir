namespace MealInformation.Models.Entities;

public class Menu
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public decimal PriceInternal { get; set; } = 0.0m;
    public decimal PriceExternal { get; set; } = 0.0m;
    public ICollection<string>? MenuComponents { get; set; } = null!;
    public ICollection<string>? Allergenes { get; set; } = null;
    public string? Balance { get; set; } = null;
    public string? EnvironmentalImpact { get; set; } = null;
    public ICollection<string>? AdditionalInformation { get; set; } = null;
    public Guid DayId { get; set; }
    public Day Day { get; set; } = null!;
    public ICollection<Icon> Icons { get; set; } = null!;
    public ICollection<NutritionalValue> NutritionalValues { get; set; } = null!;
}