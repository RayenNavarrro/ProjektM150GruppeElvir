namespace MealInformation.Models.DTOs.Response;

public class DayResponseDTO
{
    public Guid Id { get; set; }
    public DateTime Date { get; set; }
    public ICollection<MenuResponseDTO> Menus { get; set; } = null!;
}