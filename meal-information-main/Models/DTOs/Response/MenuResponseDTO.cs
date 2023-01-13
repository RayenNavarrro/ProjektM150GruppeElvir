namespace MealInformation.Models.DTOs.Response;

public class MenuResponseDTO
{
    public Guid Id { get; set; }
    public string Title { get; set; } = null!;
    public decimal PriceInternal { get; set; }
    public decimal PriceExternal { get; set; }
    public ICollection<string>? MenuComponents { get; set; } = null;
    public ICollection<string>? Allergenes { get; set; } = null;
    public string Balance { get; set; } = null!;
    public string EnvironmentalImpact { get; set; } = null!;
    public ICollection<string>? AdditionalInformation { get; set; } = null;
    public ICollection<IconResponseDTO> Icons { get; set; } = null!;
    public ICollection<NutritionalValueResponseDTO> NutritionalValues { get; set; } = null!;
}
