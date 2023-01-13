using AutoMapper;
using MealInformation.Models.DTOs.Response;
using MealInformation.Models.Entities;

namespace StudentsManual.Models;
public class AutoMapperProfile : Profile
{
    public AutoMapperProfile()
    {
        CreateMap<Day, DayResponseDTO>();
        CreateMap<Menu, MenuResponseDTO>();
        CreateMap<NutritionalValue, NutritionalValueResponseDTO>();
        CreateMap<Icon, IconResponseDTO>();
    }
}