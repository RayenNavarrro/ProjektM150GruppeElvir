namespace MealInformation.Models.Entities;

public class NutritionalValue
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string Value { get; set; } = null!;
    public int RowIndex { get; set; }
    public Guid MenuId { get; set; }
    public Menu Menu { get; set; } = null!;
}