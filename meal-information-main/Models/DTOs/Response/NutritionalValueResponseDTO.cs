namespace MealInformation.Models.DTOs.Response;

public class NutritionalValueResponseDTO
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public string Value { get; set; } = null!;
    public int RowIndex { get; set; }
}