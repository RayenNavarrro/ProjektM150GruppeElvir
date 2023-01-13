namespace MealInformation.Models.DTOs.Response;

public class IconResponseDTO
{
    public Guid Id { get; set; }
    public string SourceUri { get; set; } = null!;
    public string AltText { get; set; } = null!;
}
