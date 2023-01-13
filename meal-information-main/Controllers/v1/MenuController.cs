using AutoMapper;
using MealInformation.Models.DTOs.Response;
using MealInformation.Models.Entities;
using MealInformation.Services;
using Microsoft.AspNetCore.Mvc;
using System.Globalization;

namespace meal_information.Controllers
{
    [ApiController]
    [Route("v1/[controller]")]
    public class MenuController : Controller
    {
        private readonly ILogger<MenuController> _logger;
        private readonly MealPlanService _mealPlanService;
        private readonly DataService _dataService;
        private readonly IMapper _mapper;

        public MenuController(ILogger<MenuController> logger, MealPlanService mealPlanService, DataService dataService, IMapper mapper)
        {
            _logger = logger;
            _mealPlanService = mealPlanService;
            _dataService = dataService;
            _mapper = mapper;
        }

        [HttpGet]
        [ProducesResponseType(200)]
        [ProducesResponseType(204)]
        [ProducesResponseType(404)]
        public async Task<ActionResult<IEnumerable<DayResponseDTO>>> GetMenuPlan([FromQuery] DateTime? date, [FromQuery] bool wholeWeek = false)
        {
            DateTime mealInformationDate = date ?? DateTime.Now;

            if (!IsRequestedDayInCurrentWeek(mealInformationDate))
            {
                return NotFound(mealInformationDate);
            }

            TimeSpan noon = new TimeSpan(12, 00, 0);

            DateTime firstDaysDate = mealInformationDate.Date + noon;
            DateTime lastDaysDate = firstDaysDate;

            if (wholeWeek)
            {
                firstDaysDate = mealInformationDate.AddDays(-(((int)mealInformationDate.DayOfWeek + 6) % 7)).Date + noon;
                lastDaysDate = firstDaysDate.AddDays(4);
            }

            List<Day> menuDays = new List<Day>();

            do
            {
                var day = await _dataService.GetDay(firstDaysDate);

                if (day is null)
                {
                    day = new Day { Date = firstDaysDate };
                    day.Menus = _mealPlanService.FetchMenuesForDayOfWeek((int)firstDaysDate.DayOfWeek);
                    if (day.Menus.Count > 0)
                    {
                        day = await _dataService.PersistDay(day);
                    }
                }

                menuDays.Add(day);

                firstDaysDate = firstDaysDate.AddDays(1);
            } while (firstDaysDate <= lastDaysDate);


            return Ok(_mapper.Map<List<Day>, List<DayResponseDTO>>(menuDays));
        }
        private bool IsRequestedDayInCurrentWeek(DateTime date)
        {
            Calendar calendar = CultureInfo.InvariantCulture.Calendar;
            var requestedWeek = calendar.GetWeekOfYear(date, CalendarWeekRule.FirstDay, DayOfWeek.Sunday);
            var actualWeek = calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstDay, DayOfWeek.Sunday);

            return requestedWeek == actualWeek;
        }
    }
}